class FluxFollower < ApplicationRecord
  belongs_to :user
  belongs_to :flux_friend, class_name: 'User'

  def self.purge
    delete_all
  end

  def is_u_following(user_id, friend_id)
    user = User.find(user_id)
    follower = User.find(friend_id)
    user.friends.include?(follower)
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
          require 'pry'; binding.pry
          until !is_u_following(user.id, fake_follower.id) || fake_folloer.id != user.id

            user.friends.include?(fake_follower.id)

            fake_follower = User.find(User.pluck(:id).sample)
          end
          user.flux_friends << fake_follower
          user.save
        end
        increment += 0.2
      end
    end



    # users = User.all.order('RANDOM()')
    # increment = 0.2

    # users.each do |user|
    #   if increment >= 1.0
    #     return 0
    #   else
    #     increase = (users.count - (users.count * increment)).round
    #     (increase).times do
    #       fake_follower = User.find(User.pluck(:id).sample)
    #       user.flux_friends << fake_follower
    #       user.save
    #     end
    #     increment += 0.2
    #   end
    # end
  end
end
