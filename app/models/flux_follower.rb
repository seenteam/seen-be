class FluxFollower < ApplicationRecord
  belongs_to :user
  belongs_to :flux_friend, class_name: 'User'

  def self.purge
    delete_all
  end

  def self.distribute
    users = User.all.order('RANDOM()')
    increment = 0.2

    users.each do |user|
      if increment >= 1.0
        return 0
      else
        increase = (users.count - (users.count * increment)).round
        (increase).times do
          fake_follower = User.find(User.pluck(:id).sample)
          until user.flux_friends.include?(fake_follower) == false &&
                     fake_follower.id != user.id &&
                     user.friends.include?(fake_follower) == false do

            fake_follower = User.find(User.pluck(:id).sample)
          end
          user.flux_friends << fake_follower
        end
        increment += 0.2
      end
    end
  end
end
