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
  belongs_to :post, inverse_of: :post_tags
  belongs_to :tag, inverse_of: :post_tags

  # post_idにpresence:trueを付けて、postモデルと同時にpost_tagsを保存するとなぜか上手くいかない
  # validates :post_id, presence: true
  validates :tag_id, presence: true, uniqueness: { scope: :post_id }
end
