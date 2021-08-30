class Mutations::CreatePost < Mutations::BaseMutation
  argument :content, String, required: true
  argument :user_id, ID, required: true

  field :post, Types::PostType, null: false
  field :user, Types::UserType, null: false
  field :errors, [String], null: false

  def resolve(content:, user_id:)
    post = Post.new(content: content, user_id: user_id)
    user = User.find(user_id)
    if post.save
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
