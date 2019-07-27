require 'rails_helper'

RSpec.describe PostTag, type: :model do
  describe '#validation' do
    it { is_expected.to belong_to(:post) }
    it { is_expected.to belong_to(:tag) }
    it { is_expected.to validate_presence_of(:tag_id) }
  end
end
