# == Schema Information
#
# Table name: item_headings
#
#  id    :bigint           not null, primary key
#  title :string(255)
#

class ItemHeading < ApplicationRecord
  has_one :item, as: :target, dependent: :destroy

  validates :title, presence: true
end
