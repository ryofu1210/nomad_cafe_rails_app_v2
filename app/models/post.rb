# == Schema Information
#
# Table name: posts
#
#  id               :bigint           not null, primary key
#  user_id          :bigint
#  name             :string(255)      not null
#  description      :text(65535)
#  image            :string(255)
#  status           :integer          default("editing"), not null
#  recommend_degree :integer          default(0), not null
#  wifi             :integer          default(0), not null
#  wifi_detail      :text(65535)
#  outret           :integer          default(0), not null
#  longstay_degree  :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  area_id          :integer          not null
#

class Post < ApplicationRecord
  include DataURIToImageConverter
  is_impressionable

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :area

  belongs_to :user
  belongs_to :area
  has_many :favorites
  has_many :favorited_users, source: :user, through: :favorites
  has_one :featured_post
  has_many :items, -> { order('sortrank asc') }, dependent: :destroy, inverse_of: :post
  has_many :post_tags
  has_many :tags, through: :post_tags

  accepts_nested_attributes_for :items, reject_if: ->(attributes) { attributes['target_type'].blank? }
  mount_uploader :image, PostImageUploader

  enum status: { editing: 0, accepted: 1, deleted: 2 }

  validates :name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 150 }
  validates :area_id, presence: true
  validates :status, presence: true, inclusion: { in: Post.statuses.keys }

  scope :by_id, ->(id = nil) { where(id: id) if id.present? }
  scope :by_name, ->(name = nil) { where('name LIKE ?', "%#{name}%") if name.present? }
  scope :by_status, ->(status_ids = nil) { where(status: status_ids) if status_ids.present? }
  # scope :by_status, -> (status_ids = nil) { where('status IN ?',"#{status_ids}") if status_ids.present? }
  scope :by_user_name, lambda { |user_name = nil|
    includes(:user).references(:user).where('users.nickname LIKE ?', "%#{user_name}%") if user_name.present?
  }
  scope :updated_at_between, lambda { |from: nil, to: nil|
    return unless from || to
    return where('updated_at >= ?', from) unless to
    return where('updated_at <= ?', to) unless from

    where(updated_at: from..to)
  }
  scope :by_name_and_description, ->(word = nil) { where('posts.name LIKE ? OR description LIKE ?', "%#{word}%", "%#{word}%") if word.present? }

  scope :order_by, lambda { |status_order: nil, updated_at_order: nil|
    return unless status_order || updated_at_order

    status_sql       = status_order ? "status #{status_order}" : nil
    updated_at_sql   = updated_at_order ? "updated_at #{updated_at_order}" : nil
    order([status_sql, updated_at_sql].compact.join(','))
  }
  # scope :exclude_deleted, -> { where.not(status: 4) }
  scope :by_tag_ids, lambda { |tag_ids = nil|
    return unless tag_ids

    includes(:tags).references(:tags).where(tags: { id: tag_ids })
  }

  scope :active, -> { where(status: 1) }
  scope :order_updated_at, -> { order(updated_at: :desc) }

  scope :back_search, lambda { |search_params = {}|
    # byebug
    by_id(search_params[:id])
      .by_name(search_params[:name])
      .by_status(search_params[:status_ids])
      .by_user_name(search_params[:user_name])
      .updated_at_between(from: search_params[:from], to: search_params[:to])
      .order_by(status_order: search_params[:status_order], updated_at_order: search_params[:updated_at_order])
    # byebug
  }

  scope :user_search, lambda { |search_params = {}|
    by_name_and_description(search_params[:word])
      .by_tag_ids(search_params[:tag_ids])
  }

  # post関連テーブルitem,item_xxxをあわせたparamsを受け取り、複数テーブル同時に更新する
  def save_all(params)
    ActiveRecord::Base.transaction do
      validate_sort_rank_uniqueness!(params[:items_attributes])
      delete_unnecessary_items!(params[:items_attributes]) if id
      params[:items_attributes] = params[:items_attributes].map do |item|
        target = item[:target_type].constantize.find_or_initialize_by(id: item[:target_id])

        target.title = item[:title] if item[:title]
        target.body  = item[:body] if item[:body]
        target.image = item[:image] if item[:image]
        logger.debug(target)

        target.image = convert_data_uri_to_upload(item[:image]) if %(ItemImage).include?(target.class.name) && item[:image] && target.image.try(:url) != item['image']
        target.save!
        item_id = item[:id]
        item_sortrank = item[:sortrank]
        item_post_id = item[:post_id]
        # byebug
        item = {}
        item.merge!(
          id: item_id,
          sortrank: item_sortrank,
          post_id: item_post_id,
          target_type: target.class.name,
          target_id: target.id
        )
      end
      params[:image] = convert_data_uri_to_upload(params[:image])
      update!(params)
      true
    end
  rescue StandardError => e
    errors[:base] << e.message
    logger.error "error: #{e.message}, location: #{e.backtrace_locations}"
    false
  end

  def self.popular_posts
    post_ids = RedisService.get_daily_post_ranking(Time.zone.today)
    Post.where(id: post_ids)
        .order(['field(id, ?)', post_ids])
        .limit(6)
  end

  def self.popular_area_posts(area_id)
    post_ids = RedisService.get_daily_area_post_ranking(Time.zone.today, area_id)
    Post.where(id: post_ids)
        .order(['field(id, ?)', post_ids])
        .limit(6)
  end

  def validate_sort_rank_uniqueness!(params)
    sort_rank_list = params.map { |key, _| key['sortrank'] }
    raise ArgumentError, 'sort rank is not unique!' unless sort_rank_list.size == sort_rank_list.uniq.size
  end

  def delete_unnecessary_items!(params)
    removed_ids = items.map(&:id) - params.map { |key, _| key['id'] }
    Item.where(post_id: id, id: removed_ids).find_each(&:destroy!)
  end
end
