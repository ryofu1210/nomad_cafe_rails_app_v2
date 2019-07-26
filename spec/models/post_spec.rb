require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    # @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
  end

  describe "#validation" do
    context "正常系" do
      it "有効なPOSTの検証" do
        expect(@post).to be_valid
      end
    end

    context "異常系" do
      it "nameの存在性検証" do
        @post.name = ""
        expect(@post).not_to be_valid
      end

      it "nameの最大長さ検証" do
        @post.name = "a"*51
        expect(@post).not_to be_valid
      end

      it "descriptionの存在性検証" do
        @post.description = ""
        expect(@post).not_to be_valid
      end

      it "descriptionの最大長さ検証" do
        @post.description = "a"*151
        expect(@post).not_to be_valid
      end

      it "user_idの存在性検証" do
        @post.user_id = ""
        expect(@post).not_to be_valid
      end

      it "statusの存在性検証" do
        @post.status = nil
        expect(@post).not_to be_valid
      end
    end
  end

  describe "#search" do
    before do
      @postA = FactoryBot.create(:post,name:"nameA", description:"descriptionA")
      @postB = FactoryBot.create(:post,name:"nameB", description:"descriptionB")
      @postC = FactoryBot.create(:post,name:"nameC", description:"descriptionC")
    end

    context "引数がないとき" do
      it "全件返ってくる" do
        expect(Post.user_search()).to include(@postA,@postB,@postC)
      end
    end

    context "マッチするPostが見つかったとき" do
      it "検索結果にマッチしたPostが返ってくる" do
        expect(Post.user_search({word:"nameC"})).to include(@postC)
        expect(Post.user_search({word:"nameC"})).not_to include(@postA,@postB)
      end
    end
      
    context "マッチするPostが見つからなかったとき" do
      it "空の配列が返ってくる" do
        expect(Post.user_search({word:"No Match"})).to be_empty
      end
    end
  end

end
