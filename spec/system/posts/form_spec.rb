require 'rails_helper'

RSpec.describe 'Posts Form', type: :system, js:true  do
  let!(:user)  { create(:user, role: 'user') }
  let!(:admin) { create(:user, role: 'admin') }
  let!(:tag1) { create(:tag, name: 'TAG NAME1') }
  let!(:tag2) { create(:tag, name: 'TAG NAME2') }

  describe "新規登録" do
    before do
      sign_in(user)
      visit new_back_post_path
    end

    context "登録に成功する" do
      it '登録に成功する' do
        fill_in "post_name", with: "post name"
        fill_in "post_description", with: "post description"
        # select 'post_area_ids_1'
        select '渋谷'
        # check 'post_tag_ids_1'
        check 'TAG NAME2'
        # attach_file "写真を選択", "#{Rails.root}/spec/files/store_image.jpg"
        within '.item-component-list' do
          find('.menu-add__item_heading').click
          fill_in 'item_heading', with: 'item_heading'
          find('.item-form__btn-save').click
        end
        save_and_open_page
        expect{
          click_button "保存"
          sleep 1
          expect(page).to have_content "保存に成功"
        }.to change(Post.all, :count).by(1)
      end
    end
  end

end