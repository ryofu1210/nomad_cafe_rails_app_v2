# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string(255)
#  locked_at              :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  nickname               :string(255)      default(""), not null
#  profile                :text(65535)
#  avatar                 :string(255)
#  role                   :integer          default("user"), not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validation' do
    it { is_expected.to have_many(:posts) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:role) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to define_enum_for(:role).with_values(%i(user admin)) }
  end

  describe '#already_favorite?' do
    subject { user.already_favorite?( post_id ) }
    let(:user) { create(:user) }
    let(:post) { create(:post) }
    let(:post_id) { post.id }
    context 'favorite未登録の場合' do
      it { is_expected.to be_falsy }
    end

    context 'favorite登録済みの場合' do
      let!(:favorite) { create(:favorite, user: user, post: post ) }
      it { is_expected.to be_truthy }
    end
  end
end
