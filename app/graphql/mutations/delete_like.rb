class Mutations::DeleteLike < Mutations::BaseMutation
  argument :like_id, ID, required: true

  field :message, String, null: false
  field :errors, [String], null: false

  def resolve(like_id:)
    like = Like.find(like_id)
    if like.destroy
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
