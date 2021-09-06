class Mutations::DeleteLike < Mutations::BaseMutation
  argument :user_id, ID, required: true
  argument :post_id, ID, required: true

  field :message, String, null: false
  field :errors, [String], null: false

  def resolve(user_id:, post_id:)
    like = Like.where("user_id = ?", user_id).where("post_id = ?", post_id)
    if like.first.destroy
      {
        message: "Like Removed",
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
