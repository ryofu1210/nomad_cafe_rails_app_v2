# == Schema Information
#
# Table name: favorites
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  post_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates_uniqueness_of :post_id, scope: :user_id
end
