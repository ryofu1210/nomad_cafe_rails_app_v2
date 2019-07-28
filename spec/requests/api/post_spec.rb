require 'rails_helper'

RSpec.describe "Api::Postsontroller", type: :request do
  describe "Posts API" do
    
    describe "GET /api/posts" do
      subject { JSON.parse(response.body) }
      let(:result) do
        { 
          "post" => {
            "id" => post.id,
            "name" => post.name,
            "description" => post.description,
            "image" => post.image.url,
            "status" => post.status,
            "area_id" => post.area_id,
            "tag_ids" => post.tag_ids,
          },
          "areas" => areas.map {|area| 
            {
              "id" => area.id,
              "name" => area.name,
            }
          },
          "items" => post.items.map {|item|
            item_default_params = {
              "id"=> item.id,
              "post_id"=> item.post_id,
              "sortrank"=> item.sortrank,
              "target_type"=> item.target_type,
              "target_id"=> item.target_id,
            }
            case item.target_type
            when 'ItemHeading'
              item_default_params.merge("title"=> item.target.title)
            when 'ItemText'
              item_default_params.merge("body"=> item.target.body)
            when 'ItemImage'
              item_default_params.merge("image"=> item.target.image.url)
            end    
          },
          "tags" => tags.map {|tag|
            {
              "id" => tag.id,
              "name" => tag.name,
            }
          }
        }
      end
      let(:user) { create(:user) }
      let!(:original_post) { create(:post, user: user, area_id: area.id )}
      let(:area) { Area.first }
      let(:areas) { Area.all }
      let!(:tags) { create_list(:tag, 3) }
      let(:items_attributes) {[
        {
          target_type: 'ItemHeading',
          title: 'title',
          sortrank: 1,
        },
        {
          target_type: 'ItemText',
          body: 'body',
          sortrank: 2,
        },
      ]}

      let(:param) do
        {
          name: 'update_name',
          description: 'update_description',
          items_attributes: items_attributes
        }
      end
      let(:post) { Post.find(original_post.id) }
      # let!(:item) { create(:item) }
      
      it 'post関連情報を取得' do
        sign_in(user)
        original_post.save_all(param) 
        get edit_api_post_path(post), {}
        expect(subject).to eq result
        expect(Post.count).to eq 1
      end
    end

    describe "GET /api/posts/new" do
      subject { JSON.parse(response.body) }
      let(:result) do
        { 
          "post" => {
            "id" => nil,
            "name" => nil,
            "description" => nil,
            "image" => nil,
            "status" => "editing",
            "area_id" => nil,
            "tag_ids" => [],
          },
          "areas" => areas.map {|area| 
            {
              "id" => area.id,
              "name" => area.name,
            }
          },
          "items" => [],
          "tags" => tags.map {|tag|
            {
              "id" => tag.id,
              "name" => tag.name,
            }
          }
        }
      end

      let(:user) { create(:user) }
      let(:areas) { Area.all }
      let!(:tags) { create_list(:tag, 3) }
      

      it '空のpost,items情報を取得' do
        sign_in(user)

        get new_api_post_path, {}
        expect(subject).to eq result
        expect(Post.count).to eq 0
      end
    end

    describe "POST /api/posts" do

      let(:user) { create(:user) }
      let(:area) { Area.first }
      let!(:tags) { create_list(:tag, 3) }
      # let(:items_attributes) {[ 
      #   {
      #     "target_type"=> "ItemHeading",
      #     "sortrank"=> 1,
      #     "title"=> "title",
      #     # "target_attributes" => {
      #     # }
      #   },
      #   {
      #     "target_type"=> "ItemText",
      #     "sortrank"=> 2,
      #     "body"=> "body",
      #     # "target_attributes" => {
      #     # }
      #   },
      # ]}

      context '保存に成功する場合' do
        subject { response.status }
        let(:result) { 204 }
        let(:params){
          {
          "post"=> {
            "name"=> 'update_name',
            "description"=> 'update_description',
            "area_id"=> area.id,
            "user_id"=> user.id,
            "tag_ids"=> [tags[0].id,tags[2].id],
            "items_attributes"=> [],
            }
          }
        }
        it '204ステータスを取得' do
          sign_in(user)
          post api_posts_path, { params: params }
          expect(Post.count).to eq 1
          expect(subject).to eq result
        end
      end

      context '情報不足で保存に失敗する場合' do
        subject { response.status }
        let(:result) { 422 }
        let(:params) {
          {
          "post"=> {
            "name"=> '',
            "description"=> 'update_description',
            "area_id"=> area.id,
            "user_id"=> user.id,
            "tag_ids"=> [tags[0].id,tags[2].id],
            "items_attributes"=> [],
            }
          }
        }
        it 'エラーメッセージを取得' do
          sign_in(user)
          post api_posts_path, { params: params }
          expect(Post.count).to eq 0
          # byebug
          expect(subject).to eq result
        end
      end
    end


    describe "PATCH /api/posts/:id" do
      let(:user) { create(:user) }
      let!(:original_post) { create(:post, user_id: user.id) }
      let(:post) { Post.find(original_post.id) }
      context '更新に成功する場合' do
        subject { response.status }
        let(:result) { 204 }
        let(:params) {
          {
          "post"=> {
            "name"=> 'update_name',
            "description"=> 'update_description',
            "items_attributes"=> items_attributes,
            }
          }
        }
        let(:items_attributes) {[ 
          {
            "target_type"=> "ItemHeading",
            "sortrank"=> 1,
            "title"=> "title",
          },
          {
            "target_type"=> "ItemText",
            "sortrank"=> 2,
            "body"=> "body",
          },
        ]}

        it '204ステータスを取得' do
          sign_in(user)
          patch api_post_path(post), { params: params }
          post.reload
          expect(Post.count).to eq 1
          expect(subject).to eq result
          # byebug
          expect(post.name).to eq params["post"]["name"]
          expect(post.description).to eq params["post"]["description"]
        end
      end

      context '情報不足で更新に失敗する場合' do
        subject { response.status }
        let(:result) { 422 }
        let(:params) {
          {
          "post"=> {
            "name"=> '',
            "description"=> 'update_description',
            "items_attributes"=> items_attributes,
            }
          }
        }
        let(:items_attributes) {[ 
          {
            "target_type"=> "ItemHeading",
            "sortrank"=> 1,
            "title"=> "",
          },
          {
            "target_type"=> "ItemText",
            "sortrank"=> 2,
            "body"=> "",
          },
        ]}

        it '422ステータスを取得' do
          sign_in(user)
          patch api_post_path(post), { params: params }
          post.reload
          expect(Post.count).to eq 1
          expect(subject).to eq result
          expect(post.name).not_to eq params["post"]["name"]
          expect(post.description).not_to eq params["post"]["description"]
        end


      end
    end

  end
end