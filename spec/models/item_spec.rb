require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#validation' do
    it { is_expected.to belong_to(:post).touch(:true) }
    it { is_expected.to belong_to(:target) }
    it { is_expected.to validate_presence_of(:sortrank) }
  end
end
