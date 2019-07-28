# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy, inverse_of: :tag
  has_many :posts, through: :post_tags

  validates :name, presence: true
end
