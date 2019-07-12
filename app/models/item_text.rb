# == Schema Information
#
# Table name: item_texts
#
#  id   :bigint           not null, primary key
#  body :text(65535)
#

class ItemText < ApplicationRecord
  has_one :item, as: :target, dependent: :destroy

  validates :body, presence: true
end
