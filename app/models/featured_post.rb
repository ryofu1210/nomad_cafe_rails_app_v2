# == Schema Information
#
# Table name: featured_posts
#
#  id       :bigint           not null, primary key
#  post_id  :bigint
#  sortrank :integer          not null
#

class FeaturedPost < ApplicationRecord
  MAX_NUMBER = 6
  belongs_to :post
  validates :sortrank, presence: true, inclusion: { in: (1..MAX_NUMBER).to_a }
  validates :post_id, presence: true, uniqueness: true
end
