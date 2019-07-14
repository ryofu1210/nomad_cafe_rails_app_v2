# == Schema Information
#
# Table name: posts
#
#  id               :bigint           not null, primary key
#  user_id          :bigint
#  name             :string(255)      not null
#  description      :text(65535)
#  image            :string(255)
#  status           :integer          default(0), not null
#  recommend_degree :integer          default(0), not null
#  wifi             :integer          default(0), not null
#  wifi_detail      :text(65535)
#  outret           :integer          default(0), not null
#  longstay_degree  :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Post < ApplicationRecord
  include DataURIToImageConverter

  belongs_to :user
  # has_many :items
  has_many :items, -> { order('sortrank asc') }, dependent: :destroy, inverse_of: :post
  accepts_nested_attributes_for :items, reject_if: ->(attributes) { attributes['target_type'].blank? }
  mount_uploader :image, PostImageUploader

  enum status: { editing: 0, accepted: 1, deleted: 2}

  def save_all(params)
    # logger.debug(params)
    # byebug
    ActiveRecord::Base.transaction do
      params[:items_attributes] = params[:items_attributes].map do |item|
        target = item[:target_type].constantize.find_or_initialize_by(id: item[:target_id])

        target.title = item[:title] if item[:title]
        target.body  = item[:body] if item[:body]
        target.image = item[:image] if item[:image]
        logger.debug(target)

        if %(ItemImage).include?(target.class.name) && item[:image] && target.image.try(:url) != item['image']
          # if item[:image].start_with?('http')
          #   target.remote_image_url = item['image']
          # else
          # end
          target.image = convert_data_uri_to_upload(item[:image])
        end
        target.save!
        # byebug
        # newItem = Item.find_or_initialize_by(id: item[:id])
        # newItem.sortrank = item[:sortrank]
        # newItem.target_type = item[:target_type]
        # newItem.target_id = target.id
        # newItem.post_id = item[:post_id]
        # newItem.save!
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
      # update!({name: params[:name], description: params[:description], image:params[:image]})
      # byebug
      # post = Post.find_or_create_by(id: params[:id])
      # byebug
      update!(params)
      # save!(params)
      # update!(params)
      true
    end

    rescue => e
      errors[:base] << e.message
      logger.error "error: #{e.message}, location: #{e.backtrace_locations}"
      false  
  end
end
