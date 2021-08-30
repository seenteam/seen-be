class Mutations::UpdatePost < Mutations::BaseMutation
  argument :content, String, required: true
  argument :post_id, ID, required: true

  field :post, Types::PostType, null: false
  field :user, Types::UserType, null: false
  field :errors, [String], null: false

  def resolve(content:, post_id:)
    post = Post.find(post_id)
    user = User.find(post.user_id)
    if post.update(content: content)
      {
        post: post,
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
