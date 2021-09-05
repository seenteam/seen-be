class Mutations::DeleteFollower < Mutations::BaseMutation
  argument :user_id, ID, required: true
  argument :follower_id, ID, required: true

  field :message, String, null: false
  field :follower, Types::FollowerType, null: false
  field :errors, [String], null: false

  def resolve(user_id:, follower_id:)
    connection = Follower.where("user_id = ?", user_id).where("friend_id = ?", follower_id)
    # binding.pry
    if connection.first.destroy
      {
        message: "Your connection has been deleted!",
        follower: connection,
        errors: []
      }
    else
      {
        post: nil,
        errors: post.errors.full_messages
      }
    end
  end
end
