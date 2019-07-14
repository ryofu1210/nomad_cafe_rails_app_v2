# == Schema Information
#
# Table name: items
#
#  id          :bigint           not null, primary key
#  post_id     :bigint
#  sortrank    :integer          not null
#  target_type :string(255)
#  target_id   :bigint
#

class Item < ApplicationRecord
  belongs_to :post, touch: true, inverse_of: :items
  belongs_to :target, polymorphic: true

  # enum target_type: {
  #   heading: 'ItemHeading',
  #   text: 'ItemText',
  #   image: 'ItemImage',
  # }

  validates :sortrank, presence: true
  # validates :target_type, presence: true, inclusion: { in: Item.target_types.keys }

end
