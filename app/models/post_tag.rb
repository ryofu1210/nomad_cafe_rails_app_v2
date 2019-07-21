# == Schema Information
#
# Table name: post_tags
#
#  id         :bigint           not null, primary key
#  post_id    :bigint
#  tag_id     :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PostTag < ApplicationRecord
  belongs_to :post
  belongs_to :tag

  validates :post_id, presence: true
  validates :tag_id, presence: true, uniqueness: {scope: :post_id}
end
