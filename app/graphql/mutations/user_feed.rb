class Mutations::UserFeed < Mutations::BaseMutation
  argument :user_id, ID, required: true

  # field :post, Types::PostType, null: false
  field :like_count, Types::LikeType, null: false
  field :errors, [String], null: false

  field :get_post_from_fixed_following, [Types::PostType], null: false do
    argument :id, ID, required: true
  end

  field :get_post_from_flux_following, [Types::PostType], null: false do
    argument :id, ID, required: true
  end

  def get_post_from_fixed_following(id:)
    user = User.find(id)
    user.followers.map do |follower|
      User.find(follower.friend_id).posts
    end.flatten
  end

  def get_post_from_flux_following(id:)
    user = User.find(id)
    user.flux_followers.map do |follower|
      User.find(follower.flux_friend_id).posts
    end.flatten
  end

  def like_count(id:)
    Like.select('post_id, sum (post_id)').group('post_id').where('post_id = ?', id)
  end

  def resolve(user_id:)
    like_count = like_count(post_id)
    user = User.find(user_id)
    fixed_post = Post.new(content: content, user_id: user_id)
    # if post.save
      {
        like_count: post,
        get_post_from_fixed_following: ,
        errors: []
      }
    # else
    # end
  end
end
