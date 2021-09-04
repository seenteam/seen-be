class Mutations::CreateFollower < Mutations::BaseMutation
  argument :user_id, ID, required: true
  argument :friend_id, ID, required: true

  field :follower_id, Integer, null: false
  field :user_info, Types::UserType, null: false
  field :follower_info, Types::UserType, null: true
  field :errors, [String], null: false

  def is_following(user_id, friend_id)
    user = User.find(user_id)
    follower = User.find(friend_id)

    user.friends.include?(follower)
  end

  def resolve(user_id:, friend_id:)
    follower = Follower.new(user_id: user_id, friend_id: friend_id)
    user_information = User.find(user_id)
    follower_information = User.find(friend_id)

    if user_information == follower_information
      {
        follower_id: 0,
        user_info: user_information,
        errors: ["You cannot follow yourself"]
      }
    elsif is_following(user_id, friend_id)
      {
        follower_id: 0,
        user_info: user_information,
        errors: ["You are already following #{follower_information.first_name} #{ follower_information.last_name}!"]
      }
    elsif follower.save
      {
        follower_id: follower.id,
        user_info: user_information,
        follower_info: follower_information,
        errors: []
      }
    end
  end
end
