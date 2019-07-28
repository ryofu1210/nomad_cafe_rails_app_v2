require 'rails_helper'

RSpec.describe Post, type: :model do

  describe '#validation' do
    it { is_expected.to have_many(:favorites).dependent(:destroy) }
    it { is_expected.to have_many(:favorited_users) }
    it { is_expected.to have_one(:featured_post).dependent(:destroy) }
    it { is_expected.to have_many(:items).order('sortrank asc').dependent(:destroy) }
    it { is_expected.to have_many(:post_tags).dependent(:destroy) }
    it { is_expected.to have_many(:tags) }
    it { is_expected.to belong_to(:user) }
    # it { is_expected.to belong_to(:area) }
    it { is_expected.to accept_nested_attributes_for(:items) }

    it { is_expected.to define_enum_for(:status).with_values(%i(editing accepted deleted)) }


    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(50) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_length_of(:description).is_at_most(150) }
    it { is_expected.to validate_presence_of(:status) }
  end

  describe '#validate_sort_rank_uniqueness!' do
    subject { post.validate_sort_rank_uniqueness!(params) }
    let!(:original_post) { create(:post) }
    let(:post) { Post.find(original_post.id) }

    context 'sortrankのparamsがuniqueな場合' do
      context 'sortrankのparamsが一つ以上送られてくる場合' do
        let(:params) { [ { sortrank: 1 }, { sortrank: 2 } ] }
        
        it { 
          expect { subject }.not_to raise_error }
      end
      
      context 'sortrankのparamsが一つも送られてこない場合' do
        let(:params) { [] }
        it { expect { subject }.not_to raise_error }
      end
    end

    context 'sortrankのparamsに重複がある場合' do
      let(:params) { [{ sortrank: 1 }, { sortrank: 1 }] }
      it { expect { subject }.to raise_error(ArgumentError, 'sort rank is not unique!') }
    end
  end

  describe '#delete_unnecessary_items!' do
    let!(:original_post) { create(:post) }
    let(:post) { Post.find(original_post.id) }
    let!(:item) { create(:item, :text, post: post, id: 1) }
    let!(:item) { create(:item, :text, post: post, id: 2) }

    shared_examples 'Itemの削除' do
      subject { post.delete_unnecessary_items!(params) }
      it { expect { subject }.to change { Item.count }.by(deleted_number) }
    end
    context '削除するItemがある場合' do
      let(:params) { [{ id: 1 }] }
      let(:deleted_number) { -1 }
      it_behaves_like 'Itemの削除'
    end

    context '削除するItemがない場合' do
      let(:params) { [{ id: 1 }, { id: 2 }] }
      let(:deleted_number) { 0 }
      it_behaves_like 'Itemの削除'
    end
  end

  describe '#save_all' do
    subject { post.save_all(params) }

    context '新規保存の場合' do
      let!(:user) { create(:user) }
      let!(:post) { Post.new(user_id: user.id) }
      let!(:area) { create(:area) }
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
        {
          target_type: 'ItemImage',
          image: 'data:image/jpeg;base64,iVBORw0KGgoAAAANSUhEUgAAAKAAAACgCAMAAAC8EZcfAAAAkFBMVEXYDBj////WAADXABLhQ0z55ubYBRT42NraIyz0vsHcHyveQUj76uvnc3n51dfXAATna3LeKDT++frwqa3njZDwoab98/TXAAvcO0H74eP0xcfum5/+9/f2y83ytrnZER3rh4zne4DcMTnjWF/ncXfjXGLbFiPwuLrogITjUlrgSlHkZGrrkpbunaHbLzbxv8DkuWh5AAAHsUlEQVR4nO2cbXOyOhCGMdGICoKgBFBAVCyK1f//7052A/hSsO3UPuXM5P5EQTYXye5mQ5hq/Y5Lox2XpqSkpKT0PxElD+LsFWYZmHqFJXo0H1ToL7DL9qlppvsXWCJe71Gm9XOzdAaWZi+YUUk8CEBOhTc6+aVZ/oNB+hogtPCZJbb3QTND4k2zcVlIMJJFg2XyGSFjlDb85iuAjPRHw+XnhFjckAHyxXWfscSFE4vnfUBJovvn5GMjXwBk2hJH7FNClAQM9NoiWcgBv40Yyh+CnOupGwaRa3+I/C8A8hO2YHwH8FT+WICc5ZC/X1vmZFzM3WXBZAxBHvEj6bre+toKk8lKvwfkeJLeGCMH6VUuqe955vEScCMtkOPSncLfq0V5BkwcRgbgeNMt0DBtt3CDKrKCA5e/E2OeTg1jmk5uAQnZuoYxdGcVIjkuZAu9OGGMWHY4MAaXlLf3pgSU16kPxwPTqp+Zcd02eo7xXriC0TsKGoIuGuqE5CtxsJSAXJ/DM1SpqwQkpgcnxa2xzBCWDb8w1thrdJ/DPYbhPXN5BCzdwdqB8e21wxkvol5vmHNikVBcmovfkSE8xJiLroRTMeZkuhHH3nK7XXo3gCSFR8m2JhhBQgKP4aSyBQqxEmX72XEeLlpTOwJOS0D72ptyeN+Fu8QTsIeA4DYERugNfoR9icHEEhFZzolbFp87NaBVCNpwTDjRhZmQVIDDPvY63w7gWPSk8Mv2rIaAoxvAoAakGNBuAub4BjzbrABd2ZpTAvKjGG0jEVTUMipAxkbCmdOaC7xaAk5k/8JxNC59qY1PAi5uAKcVIJ1F4GPgjczC4wDbaAAkkDjeSd0sAqK/RdiXfOLILrwFtOAmL+fW8ymhFZDtR+BiY0wDWxjgVQp92QgIUb2VA3eoAcHFQhw76gvHNUTOvOvBHBOVW+zJs6zZCkhiTDfr+Xy9uGCor7GxRsBrYNSJmmkLdFaZHAFQhMktIFJDhEanzZOc3QZICrzbAcmjjOFYNADScROg/gZPOJCCJJXxO0CNZ2Wh4ngnwr8JyCfCgRyj0mCUkdJXmgBnjYCj3p2G9H6IhYFxXUuVkf1lQJaA9XAzLkWuT9gAyLQmwD34iDEaXaTeMMvfAWqc5mE5KYVt1XIzIIEI9HaEMilq1fNpqw/KyZHWczEDHwxvVhTaB0CRaZPDKcRutFuq5UZAWXJFMjsBnG+vzYnsxUZAOJdhCzyrAGWe0+8i9BEQJiuiF6s6S30RkPqi4x2Y2ES2PtuuHIUgo22Aaa+cXcqpGgD5URgxsqqYYB8B63pkfWX4BqBXiEmK6KlI0dN4HguYQb8lUVNfWPE2HIqG60xCwQmX2K+U+jjZ3gHuN2UNjxkx/xbgBlLUKNvarij8gvwsXOjSK4uFBkCNrsWhK56Hyt4u5w8DupBYFtkvA/vRB0UhEs8IXB0Lk4NJS7ZuieJ3zPJYPkUbDh036t0UC4+A0mlD0wx7V0BR/EEmdAv73esFE/oACFOpEZu2vQR/yttmEyKqTK8sqHkhijOsOpiVBoaH0bXA8LUgL8piIRQ3oEeTfGAYrkwPjBwCrLS8ID0FThkaJImlEWNJZYTl0EK5eqSiXHRkoo4mrXMJgzRXFWMJ/FHmY7IxIUW5GMrWBosFsHxzwx4OK0MWL5ZvF7cQ47w/VlmTEj+/XNx0XNaYDFtI6t7R8J702D6RQFXEGLv9o7KtgY+PdHAScgQ+L6X3N9zdCglDCOYbdjNc9H5Ncn+LGKk6RX5bWAx668K27fUIR2/5pGr79yL2/Uy68g4veSX0KvE+5LNgWCp6y/dfW8b+IzEGDhgeJ6XGvFPdJwZ4B8WCSeTeD+fgy7xDe0Ay715oWSwkm8w0ze0r3qm9SDjVOZi+GZml5YuEqOjMMMtiwSZixcrTqdObLucLURIN/K70IQL24pnefw9WPcM8ixw8KouFbojOrxkwtEhVLLTVbP9ebD+PAgMKXSeWxYIPk0naGUARG/oxxXFOsLQ7X6pioTOiHEu8Pc7muMhz1l3iq4qFnWnu1jHOxu+dmk3I7r5YcIZmdxxQg/UELAXkTopQ5K79TvHJV0fh0S91TqxO+Z9m4ctlm9Tfivyh97EGUYbFgkabLj7o1/nGTZrAunjRfO1Bvw0Iy84G4Qqy8cqD3Ffs4T4FHPR+pJECVIAKUMzDQXS5XEKjo4CrOD9A0ZVkUScB44ksCSkj42H3AMMN4dxfG73pmcoXkp0CXJ04Z0kOpb9zpOWOUocAjVzU0MRd4UjvWbkj3x1Ab2eJxZP8CAS3E8iyU4BGRkStg8sRZ3gk1XvqzgA6BexHHGLYZssTCzbdu5Vm5NYUrb5rYaSR7+8AQ9hJ4DdfF5oN4/uHgIOtcEBmyw8Ld3O3IUX/LWAMHxiYTuO1LgB6mVV+9dFRwIEIC6vF6zoCKCIE07L31o+7ClhEw9DtE3LqIKChw+b0ua+J/LJ+Wu/8VRS/VZ8eHqLnofxnidpY7EwzdT+Nk78uWD+VAlSAClABKkAFqAAVoAJUgApQASpABagAFaACVIAKUAEqwO4CNn5s0iXAcPgjLca/DEj9yY+0+V08IFT/aExJSUlJSUlJSUlJSUlJSUlJSUlJSUlJ6j+Q0KaL38TczAAAAABJRU5ErkJggg==',
          sortrank: 3,
        },
      ]}
  

      context '保存に成功する場合' do
        let(:params) do
          {
            name: 'name',
            description: 'description',
            user_id: user.id,
            area_id: area.id,
            items_attributes: items_attributes
          }
        end
        it '保存に成功してtrueを返す' do
          
          expect(subject).to be_truthy
          expect(Post.count).to eq 1
        end
      end

      context '保存に失敗する場合' do
        shared_examples '保存に失敗する' do
          it '保存に失敗する'  do
            expect(subject).to be_falsey
            expect(Post.count).to eq 0
          end
        end

        context 'Postの情報に不足があり、保存に失敗する場合' do
          let(:params) do
            {
              description: 'description',
              user_id: user.id,
              items_attributes: items_attributes,
            }
          end
          it_behaves_like '保存に失敗する'
        end
        context 'Itemの情報に不足があり、保存に失敗する場合' do
          let(:params) do
            {
              name: 'name',
              description: 'description',
              user_id: user.id,
              area_id: area.id,
              items_attributes:
                items_attributes
                .push({ target_type: 'ItemHeading'})
            }
          end
          it_behaves_like '保存に失敗する'
        end
      end
    end
    context '更新の場合' do
      let!(:area) { create(:area) }
      let!(:tag) { create(:tag) }
      let!(:original_post) { create(:post, area_id: area.id) }
      let(:post) { Post.find(original_post.id) }
      let(:post_tag) { create(:post_tag, post_id: post.id, tag_id: tag.id ) }
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
        {
          target_type: 'ItemImage',
          image: 'data:image/jpeg;base64,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',
          sortrank: 3,
        },
      ]}

      context '更新に成功する場合' do
        let(:params) do
          {
            name: 'name_update',
            items_attributes: items_attributes
          }
        end
        it '保存に成功してtrueを返す' do
          expect(subject).to be_truthy
          expect(Post.count).to eq 1
          expect(Post.find(post.id).name).not_to eq 'name_updated'
          expect(Post.last.items.size).to eq 3
          expect(Item.where(post_id: post.id, target_type: 'ItemHeading').count).to eq 1
          expect(Item.where(post_id: post.id, target_type: 'ItemText').count).to eq 1
          expect(Item.where(post_id: post.id, target_type: 'ItemImage').count).to eq 1
        end
      end

      context '更新に失敗する場合' do
        let(:params) do
          {
            name: '',
            items_attributes: items_attributes
          }
        end
        it '保存に成功してtrueを返す' do
          expect(subject).to be_falsey
          expect(Post.count).to eq 1
          expect(Post.find(post.id).name).not_to eq 'name_updated'
          expect(Post.last.items.size).not_to eq 3
          expect(Item.where(post_id: post.id, target_type: 'ItemHeading').count).not_to eq 1
          expect(Item.where(post_id: post.id, target_type: 'ItemText').count).not_to eq 1
          expect(Item.where(post_id: post.id, target_type: 'ItemImage').count).not_to eq 1
        end
      end
    end

  end



  describe '#by_id' do
    subject { Post.by_id(param).map(&:id) }
    context 'idがある場合' do
      let!(:post1) { create(:post) }
      let!(:post2) { create(:post) }
      let(:param) { post1.id }
      let(:result) { [post1.id] }
      it { is_expected.to eq result }
    end
  end

  describe '#by_name' do
    subject { Post.by_name(param).map(&:id) }

    context 'nameがある場合' do
      let!(:post1) { create(:post, name: 'name_abc') }
      let!(:post2) { create(:post, name: 'abc_name') }
      let!(:post3) { create(:post, name: 'hogehoge') }
      let(:param) { 'name' }
      let(:result) { [post1.id, post2.id] }

      it { is_expected.to eq result }
    end
  end

  describe '#by_name_and_description' do
    subject { Post.by_name(param).map(&:id) }

    context 'nameがある場合' do
      let!(:post1) { create(:post, name: 'name_abc', description: 'desc_abc' ) }
      let!(:post2) { create(:post, name: 'name_efg', description: 'desc_efg' ) }
      let!(:post3) { create(:post, name: 'hogehoge', description: 'hogehoge' ) }
      let(:param) { 'name' }
      let(:result) { [post1.id, post2.id] }
    end

    context 'descriptionがある場合' do
      let!(:post1) { create(:post, name: 'name_abc', description: 'desc_abc' ) }
      let!(:post2) { create(:post, name: 'name_efg', description: 'desc_efg' ) }
      let!(:post3) { create(:post, name: 'hogehoge', description: 'hogehoge' ) }
      let(:param) { 'desc' }
      let(:result) { [post1.id, post2.id] }
    end

  end


  describe '#by_status' do
    subject { Post.by_status(param).map(&:id) }

    context 'statusがある場合' do
      let!(:post1) { create(:post, status: 'editing') }
      let!(:post2) { create(:post, status: 'accepted') }
      let!(:post3) { create(:post, status: 'deleted') }
      let(:param) { [0, 1] }
      let(:result) { [post1.id, post2.id] }

      it { is_expected.to eq result }
    end
  end

  describe '.by_user_name' do
    subject { Post.by_user_name(param).map(&:id) }

    context 'user_nameがある場合' do
      let!(:user1) { create(:user, nickname: 'abc_user') }
      let!(:post1) { create(:post, user: user1) }
      let!(:user2) { create(:user, nickname: 'user_abc') }
      let!(:post2) { create(:post, user: user2) }
      let!(:user3) { create(:user, nickname: 'hogehoge') }
      let!(:post3) { create(:post, user: user3) }
      let(:param) { 'user' }
      let(:result) { [post1.id, post2.id] }

      it { is_expected.to eq result }
    end
  end

  describe '#updated_at_between' do
    subject { Post.updated_at_between(from: from, to: to).map(&:id) }

    let!(:post1) { create(:post, updated_at: Time.current - 10.days) }
    let!(:post2) { create(:post, updated_at: Time.current) }
    let!(:post3) { create(:post, updated_at: Time.current + 10.days) }

    context 'fromとtoの両方がない場合' do
      let(:from) { nil }
      let(:to) { nil }
      let(:result) { [post1.id, post2.id, post3.id] }

      it { is_expected.to eq result }
    end

    context 'fromだけある場合' do
      let(:from) { Time.current - 1.day }
      let(:to) { nil }
      let(:result) { [post2.id, post3.id] }

      it { is_expected.to eq result }
    end

    context 'toだけある場合' do
      let(:from) { nil }
      let(:to) { Time.current + 1.day }
      let(:result) { [post1.id, post2.id] }

      it { is_expected.to eq result }
    end

    context 'fromとtoの両方ある場合' do
      let(:from) { Time.current - 11.days }
      let(:to) { Time.current + 1.day }
      let(:result) { [post1.id, post2.id] }

      it { is_expected.to eq result }
    end
  end

  describe '.by_tag_ids' do
    subject { Post.by_tag_ids(param).map(&:id) }

    context 'tagがある場合' do
      let!(:post1) { create(:post) }
      let!(:tag1) { create(:tag, name: 'abc_tag') }
      let!(:post_tag1) { create(:post_tag, post: post1, tag: tag1) }
      let!(:post2) { create(:post) }
      let!(:tag2) { create(:tag, name: 'tag_abc') }
      let!(:post_tag2) { create(:post_tag, post: post2, tag: tag2) }
      let!(:post3) { create(:post) }
      let!(:tag3) { create(:tag, name: 'hogehoge') }
      let!(:post_tag3) { create(:post_tag, post: post3, tag: tag3) }
      let(:param) { [tag1.id, tag2.id] }
      let(:result) { [post1.id, post2.id] }

      it { is_expected.to eq result }
    end
  end

  describe '#active' do
    subject { Post.active().map(&:id) }
    let!(:post1) { create(:post, status: 0) }
    let!(:post2) { create(:post, status: 1) }
    let!(:post3) { create(:post, status: 2) }
    let(:result) { [post2.id] }
    it { is_expected.to eq result }
  end


  describe '#order_by' do
    subject { Post.order_by(status_order: status, updated_at_order: updated_at).map(&:id) }
    shared_examples '適した並び順で記事IDをかえす' do
      it { is_expected.to eq result }
    end

    context 'status_orderだけある場合' do
      let!(:post1) { create(:post, status: 'editing') }
      let!(:post2) { create(:post, status: 'deleted') }
      let!(:post3) { create(:post, status: 'accepted') }

      let(:status) { 'desc' }
      let(:updated_at) { nil }
      let(:result) { [post2.id, post3.id, post1.id] }
      it_behaves_like '適した並び順で記事IDをかえす'
    end

    context 'updated_at_orderだけある場合' do
      let!(:post1) { create(:post, updated_at: Time.current) }
      let!(:post2) { create(:post, updated_at: Time.current + 1.day) }
      let!(:post3) { create(:post, updated_at: Time.current - 1.day) }
      let(:status) { nil }
      let(:updated_at) { 'desc' }
      let(:result) { [post2.id, post1.id, post3.id] }
      it_behaves_like '適した並び順で記事IDをかえす'
    end

    context 'status_orderとupdated_at_orderの両方ある場合' do
      let!(:post1) { create(:post, status: 'deleted') }
      let!(:post2) { create(:post, status: 'accepted', updated_at: Time.current) }
      let!(:post3) { create(:post, status: 'accepted', updated_at: Time.current + 1.day) }
      let!(:post4) { create(:post, status: 'accepted', updated_at: Time.current - 1.day) }
      let(:status) { 'desc' }
      let(:updated_at) { 'asc' }
      let(:result) { [post1.id, post4.id, post2.id, post3.id] }
      it_behaves_like '適した並び順で記事IDをかえす'
    end
  end

  describe '#back_search' do
    subject { Post.back_search(params).map(&:id) }

    let!(:user1) { create(:user, nickname: 'abc_user') }
    let!(:post1) { create(:post, user: user1, status: 'editing', updated_at: Time.current) }
    let!(:user2) { create(:user, nickname: 'abc') }
    let!(:post2) { create(:post, user: user2, status: 'accepted', updated_at: Time.current + 2.days) }
    let!(:user3) { create(:user, nickname: 'user') }
    let!(:post3) { create(:post, user: user3, status: 'deleted', updated_at: Time.current + 1.day) }

    context '検索条件がある場合' do
      let(:params) { { user_name: 'user', status_ids: [0, 1] } }
      let(:result) { [post1.id] }

      it { is_expected.to eq result }
    end

    context '検索条件がない場合' do
      let(:params) { {} }
      let(:result) { [post1.id, post2.id, post3.id] }

      it { is_expected.to eq result }
    end
  end

  describe '#user_search' do
    subject { Post.user_search(params).map(&:id) }

    let!(:tag1) { create(:tag) }
    let!(:post1) { create(:post, name: 'abc_store', description: 'abc_description') }
    let!(:post_tag1) { create(:post_tag, post: post1, tag: tag1) }
    let!(:post2) { create(:post, name: 'hogehoge', description: 'hogehoge') }
    let!(:post_tag2) { create(:post_tag, post: post2, tag: tag1) }
    let!(:post3) { create(:post) }

    context '検索条件がある場合' do
      let(:params) { { word: 'abc', tag_ids: [tag1.id] } }
      let(:result) { [post1.id] }

      it { is_expected.to eq result }
      
    end

    context '検索条件がない場合' do
      let(:params) { {} }
      let(:result) { [post1.id, post2.id, post3.id] }

      it { is_expected.to eq result }
    end
  end


end
