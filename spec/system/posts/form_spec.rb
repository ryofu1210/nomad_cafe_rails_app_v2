require 'rails_helper'

RSpec.describe 'Posts Form', type: :system do
  # let!(:user)  { create(:user, role: 'user') }
  # let!(:admin) { create(:user, role: 'admin') }

  # describe "新規登録" do
  #   before do
  #     sign_in(user)
  #     visit new_back_post_path
  #   end

  #   context "登録に成功する" do
  #     it '登録に成功する' do
  #       expect {
  #         fill_in "name", with: "post name"
  #         fill_in "description", with: "post description"
  #         check ''
  #         attach_file "写真を選択", "#{Rails.root}/spec/files/store_image.jpg"
  #         click_button "保存"

  #         expect(page).to have_css "div.bg-success.notice"
  #         expect(page).to have_content("TEST NAME")
  #       }.to change(@user.stores, :count).by(1)
  #     end
  #   end

end