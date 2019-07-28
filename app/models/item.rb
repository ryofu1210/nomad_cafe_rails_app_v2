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
  belongs_to :post, touch: true , inverse_of: :items
  belongs_to :target, polymorphic: true
  accepts_nested_attributes_for :target
  # attr_accessible :target_attributes
  # enum target_type: {
  #   heading: 'ItemHeading',
  #   text: 'ItemText',
  #   image: 'ItemImage',
  # }

  # def attributes=(attributes = {})
  #   self.target_type = attributes[:target_type]
  #   super
  # end

  # def target_attributes=(attributes)
  #   some_target = self.target_type.constantize.find_or_initilize_by_id(self.target_id)
  #   some_target.attributes = attributes
  #   self.target = some_target
  # end

  validates :sortrank, presence: true
  # validates :target_type, presence: true, inclusion: { in: Item.target_types.keys }
end
