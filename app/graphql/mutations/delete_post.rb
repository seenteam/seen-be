class Mutations::DeletePost < Mutations::BaseMutation
  argument :post_id, ID, required: true

  field :message, String, null: false
  field :user, Types::UserType, null: false
  field :errors, [String], null: false

  def resolve(post_id:)
    post = Post.find(post_id)
    user = User.find(post.user_id)
    if post.destroy
      {
        message: "Post Deleted!",
        user: user,
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
