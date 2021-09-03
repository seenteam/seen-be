class Mutations::DeleteFollower < Mutations::BaseMutation
  argument :connection_id, ID, required: true

  field :message, String, null: false
  field :follower, Types::FollowerType, null: false
  field :errors, [String], null: false

  def resolve(connection_id:)
    connection = Follower.find(connection_id)
    if connection.destroy
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
