# == Schema Information
#
# Table name: item_images
#
#  id    :bigint           not null, primary key
#  image :string(255)
#

class ItemImage < ApplicationRecord
  has_one :item, as: :target, dependent: :destroy

  mount_uploader :image, ItemImageUploader
  # validates :image, presence: true
end
