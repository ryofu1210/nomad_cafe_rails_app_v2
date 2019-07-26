require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe '#validation' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:post) }
    it { is_expected.to validate_presence_of(:post) }
  end
end
