# == Schema Information
#
# Table name: areas
#
#  id    :bigint           not null, primary key
#  title :string(255)
#

class Area < ApplicationRecord
  has_many :posts
end
