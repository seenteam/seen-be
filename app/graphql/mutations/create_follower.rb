class Mutations::CreateFollower < Mutations::BaseMutation
  argument :user_id, ID, required: true
  argument :friend_id, ID, required: true


  field :follower, Types::FollowerType, null: false
  field :user_info, Types::UserType, null: false
  field :follower_info, Types::UserType, null: false
  field :errors, [String], null: false

  def resolve(user_id:, friend_id:)
    follower = Follower.new(user_id: user_id, friend_id: friend_id)
    user_information = User.find(user_id)
    follower_information = User.find(friend_id)
    if follower.save
      {
        follower: follower,
        user_info: user_information,
        follower_info: follower_information,
        errors: []
      }
    else
      {
        user: nil,
        errors: user.errors.full_messages
      }
    end
  end
end
