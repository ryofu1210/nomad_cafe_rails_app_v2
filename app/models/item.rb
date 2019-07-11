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
  belongs_to :post
  belongs_to :target, polymorphic: true
end
