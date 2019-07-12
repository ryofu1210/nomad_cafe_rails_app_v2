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
  belongs_to :user
  # has_many :items
  has_many :items, -> { order('sortrank asc') }, dependent: :destroy
  accepts_nested_attributes_for :items, reject_if: ->(attributes) { attributes['target_type'].blank? }
  mount_uploader :image, PostImageUploader

  def save_all(params)
    logger.debug(params)
    # byebug
    ActiveRecord::Base.transaction do
      params[:items_attributes].each do |item|
        target = item[:target_type].constantize.find_or_initialize_by(id: item[:target_id])

        target.title = item[:title] if item[:title]
        target.body  = item[:body] if item[:body]
        target.image = item[:image] if item[:image]
        logger.debug(target)
        target.save!

        # item_id = item['id']
        # item_sortrank = item['sortrank']
        # item.clear.merge!(
        #   id: item_id,
        #   sortrank: item_sortrank,
        #   target_id: target.id,
        #   target_type: target.class.name
        # )
        newItem = Item.find_or_initialize_by(id: item[:id])
        newItem.sortrank = item[:sortrank]
        newItem.target_type = item[:target_type]
        # item_target_type = item[:target_type]
        newItem.target_id = target.id
        newItem.post_id = item[:post_id]
        # item_params = {sortrank: item[:sortrank],
        #            target_type: item[:target_type],
        #            target_id: target.id          
        #           }
        # byebug
        newItem.save!
      end
      # update!(params)
      true
    end

    rescue => e
      errors[:base] << e.message
      logger.error "error: #{e.message}, location: #{e.backtrace_locations}"
      false  
  end
end
