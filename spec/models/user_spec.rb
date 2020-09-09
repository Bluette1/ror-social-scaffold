require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    described_class.new(name: 'some_name', email: 'em@gm.com')
  end

  describe 'Associations' do
    it { should have_many(:friendships) }
    it { should have_many(:inverse_friendships) }
    it { should have_many(:requested_friendships) }
    it { should have_many(:requested_friends).through(:requested_friendships) }
    it { should have_many(:requesting_friendships) }
    it { should have_many(:requesting_friends).through(:requesting_friendships) }
  end
end
