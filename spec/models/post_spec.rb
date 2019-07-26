require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    # @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
  end

  describe '#validation' do
    it { is_expected.to have_many(:favorites).dependent(:destroy) }
    it { is_expected.to have_many(:favorited_users) }
    it { is_expected.to have_one(:featured_post).dependent(:destroy) }
    it { is_expected.to have_many(:items).order('sortrank asc').dependent(:destroy) }
    it { is_expected.to have_many(:post_tags).dependent(:destroy) }
    it { is_expected.to have_many(:tags) }
    it { is_expected.to belong_to(:user) }
    # it { is_expected.to belong_to(:area) }
    it { is_expected.to define_enum_for(:status).with(%i(editing accepted deleted)) }


    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_length_of(:description).is_at_most(150) }
    it { is_expected.to validate_presence_of(:status) }
  end

  describe '#search' do
    before do
      @postA = FactoryBot.create(:post, name: 'nameA', description: 'descriptionA')
      @postB = FactoryBot.create(:post, name: 'nameB', description: 'descriptionB')
      @postC = FactoryBot.create(:post, name: 'nameC', description: 'descriptionC')
    end

    context '引数がないとき' do
      it '全件返ってくる' do
        expect(Post.user_search).to include(@postA, @postB, @postC)
      end
    end

    context 'マッチするPostが見つかったとき' do
      it '検索結果にマッチしたPostが返ってくる' do
        expect(Post.user_search(word: 'nameC')).to include(@postC)
        expect(Post.user_search(word: 'nameC')).not_to include(@postA, @postB)
      end
    end

    context 'マッチするPostが見つからなかったとき' do
      it '空の配列が返ってくる' do
        expect(Post.user_search(word: 'No Match')).to be_empty
      end
    end
  end
end
