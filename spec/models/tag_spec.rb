require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe '#validation' do
    it { is_expected.to have_many(:post_tags) }
    it { is_expected.to have_many(:posts) }
    it { is_expected.to validate_presence_of(:name) }
  end
end
