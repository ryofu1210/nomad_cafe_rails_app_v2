require 'rails_helper'

RSpec.describe 'Posts Form', type: :system, js:true  do
  let!(:tag1) { create(:tag, name: 'TAG NAME1') }
  let!(:tag2) { create(:tag, name: 'TAG NAME2') }

  describe "新規登録" do
    # let!(:user)  { create(:user, role: 'user') }
    # let!(:admin) { create(:user, role: 'admin') }

  
    # before do
    #   sign_in(user)
    #   visit new_back_post_path
    # end

    # context "登録に成功する" do
    #   it '登録に成功する' do
    #     fill_in "post_name", with: "post name"
    #     fill_in "post_description", with: "post description"
    #     # select 'post_area_ids_1'
    #     select '渋谷'
    #     # check 'post_tag_ids_1'
    #     check 'TAG NAME2'
    #     pending 'post新規登録時にitemの同時保存ができない'
    #     # attach_file "写真を選択", "#{Rails.root}/spec/files/store_image.jpg"
    #     within '.item-component-list' do
    #       find('.menu-add__item_heading').click
    #       fill_in 'item_heading', with: 'item_heading'
    #       find('.item-form__btn-save').click
    #     end
    #     # save_and_open_page
    #     expect{
    #       click_button "保存"
    #       sleep 1
    #       expect(page).to have_content "保存に成功"
    #     }.to change(Post.all, :count).by(1)
    #   end
    # end
  end

  describe "更新" do
    let!(:user)  { create(:user, role: 'user') }
    let!(:area) { Area.first }
    let!(:original_post) { create(:post, name:'post_name' ,area_id: area.id, user_id: user.id, tag_ids:[tag1.id]) }
    let(:post) { Post.find(original_post.id) }
    # let(:post_tag) { create(:post_tag, post_id: post.id, tag_id: tag1.id ) }

    before do
      sign_in(user)
      visit edit_back_post_path(post)
      sleep 2
    end

    context "更新に成功する" do
      it '更新に成功する' do
        save_and_open_page
        within '.form-header' do
          fill_in "店舗名", with: "update_post_name"
          fill_in "post_description", with: "update_post_description"
          select '六本木'
          check 'TAG NAME2'
        end

        within '.item-component-list' do
          find('.menu-add__item_heading').click
          fill_in 'item_heading', with: 'update_item_heading'
          find('.item-form__btn-save').click
        end
        # save_and_open_page
        expect{
          click_button "保存"
          sleep 1
          expect(page).to have_content "update_post_name"
          expect(page).to have_content "保存に成功"
        }.to change(Post.all, :count).by(0)
      end
    end
  end


end