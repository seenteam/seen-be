class Mutations::CreateLike < Mutations::BaseMutation
  argument :user_id, ID, required: true
  argument :post_id, ID, required: true

  field :user, Types::UserType, null: false
  field :post, Types::PostType, null: false
  field :like, Types::LikeType, null: false
  field :errors, [String], null: false

  def resolve(user_id:, post_id:)
    user = User.find(user_id)
    post = Post.find(post_id)
    like = Like.new(user_id: user_id, post_id: post_id)
    if like.save
      {
        like: like,
        user: user,
        post: post,
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
