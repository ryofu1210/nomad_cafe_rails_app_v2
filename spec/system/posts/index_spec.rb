require 'rails_helper'

RSpec.describe 'search posts', type: :system do
  let!(:user)  { create(:user, role: 'user') }
  let!(:admin) { create(:user, role: 'admin') }
  let!(:post1) { create(:post, status: 'editing' , name: 'hoge1', user: user) }
  let!(:post2) { create(:post, status: 'accepted', name: 'hoge2', user: user, updated_at: Time.current + 1.days ) }
  let!(:post3) { create(:post, status: 'deleted' , name: 'foo3',  user: user) }
  let!(:post4) { create(:post, status: 'accepted', name: 'hoge4',) }


  describe "Post一覧表示機能" do
    context 'Userのroleがuserの場合' do
      before do
        sign_in(user)
        visit back_posts_path
      end

      it '検索なしの場合' do
        expect(page).to have_content post1.name
        expect(page).to have_content post2.name
        expect(page).to have_content post3.name
        expect(page).not_to have_content post4.name
      end

      it 'IDで検索する' do
        fill_in 'post_id', with: post2.id
        click_on '検索'
        sleep 1
        expect(page).to have_content post2.name
        expect(page).not_to have_content post1.name
        expect(page).not_to have_content post3.name
      end

      it '掲載ステータスで検索する' do
        check 'post_status_ids_1'
        click_on '検索'
        sleep 1
        expect(page).to have_content post2.name
        expect(page).not_to have_content post1.name
        expect(page).not_to have_content post3.name
      end

      it '店名で検索する' do
        fill_in 'post_name', with: post2.name
        click_on '検索'
        sleep 1
        expect(page).to have_content post2.name
        expect(page).not_to have_content post1.name
        expect(page).not_to have_content post3.name
      end

      it '店名で検索して更新日時で更新する' do
        fill_in 'post_name', with: 'hoge'
        click_on '検索'
        find(:xpath, "//a[@href='/back/posts?post%5Bupdated_at_order%5D=desc']").click
        sleep 1
        expect(find(:xpath, '//tbody/tr[1]')).to have_content post2.name  
        expect(find(:xpath, '//tbody/tr[2]')).to have_content post1.name
      end
    end

    context 'Userのroleがadminの場合' do
      before do
        sign_in(admin)
        visit back_posts_path
      end

      it '検索なしの場合' do
        # save_and_open_page
        expect(page).to have_content post1.name
        expect(page).to have_content post2.name
        expect(page).to have_content post3.name
        expect(page).to have_content post4.name
      end
    end

  end
end