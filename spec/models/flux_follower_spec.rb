require 'rails_helper'

RSpec.describe FluxFollower, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:flux_friend) }
  end
  describe 'class methods' do
    describe '.purge' do
      it 'deletes all entries on table' do
        10.times do
          create(:user)
        end

        user1 = User.first

        User.all.map do |user|
          user1.flux_friends << user
        end
        FluxFollower.purge

        expect(user1.flux_friends.count).to eq(0)
      end
    end
    describe '.purge' do
      it 'deletes all entries on table' do
        10.times do
          create(:user)
        end

        FluxFollower.distribute
        first_id = FluxFollower.first.user_id
        user1 = User.find(first_id)

        expect(user1.flux_friends.count).to eq(8)
      end
    end
  end
end
