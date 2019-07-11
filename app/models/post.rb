# == Schema Information
#
# Table name: posts
#
#  id               :bigint           not null, primary key
#  user_id          :bigint
#  name             :string(255)      not null
#  description      :text(65535)
#  image            :string(255)
#  status           :integer          default(0), not null
#  recommend_degree :integer          default(0), not null
#  wifi             :integer          default(0), not null
#  wifi_detail      :text(65535)
#  outret           :integer          default(0), not null
#  longstay_degree  :integer          default(0), not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Post < ApplicationRecord
  belongs_to :user
  has_many :items

  mount_uploader :image, PostImageUploader
end
