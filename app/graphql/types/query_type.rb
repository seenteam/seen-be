module Types
  class QueryType < Types::BaseObject
    field :users, [Types::UserType], null: false
    def users
      User.all
    end

    field :user, Types::UserType, null: false do
      argument :id, ID, required: true
    end

    def user(id:)
      User.find(id)
    end

    field :posts, [Types::PostType], null: false
    def posts
      Post.all
    end

    field :post, Types::PostType, null: false do
      argument :id, ID, required: true
    end

    def post(id:)
      Post.find(id)
    end

    field :post_likes, [Types::UserType], null: false do
      argument :id, ID, required: true
    end

    def post_likes(id:)
      Like.where('post_id = ?', id).map do |like|
        User.find(like.user_id)
      end
    end

    field :users_liked_posts, [Types::UserType], null: false do
      argument :id, ID, required: true
    end

    def users_liked_posts(id:)
      Like.where('user_id = ?', id).map do |like|
        Post.find(like.post_id)
      end
    end

    field :user_following, [Types::UserType], null: false do
      argument :id, ID, required: true
    end

    def user_following(id:)
      Follower.where('friend_id = ?', id).map(&:user)
    end

    field :followers, [Types::FollowerType], null: false
    def followers
      Follower.all
    end

    field :follower, Types::FollowerType, null: false do
      argument :id, ID, required: true
    end

    def follower(id:)
      Follower.find(id)
    end

    field :users_followers, [Types::UserType], null: false do
      argument :id, ID, required: true
    end

    def users_followers(id:)
      user = User.find(id)
      user.followers.map do |follower|
        User.find(follower.friend_id)
      end
    end

    field :user_flux_following, [Types::UserType], null: false do
      argument :id, ID, required: true
    end

    def user_flux_following(id:)
      FluxFollower.where('flux_friend_id = ?', id).map(&:user)
    end

    field :users_flux_followers, [Types::UserType], null: false do
      argument :id, ID, required: true
    end

    def users_flux_followers(id:)
      user = User.find(id)
      user.flux_followers.map do |follower|
        User.find(follower.flux_friend_id)
      end
    end

    field :get_post_from_fixed_following, [Types::PostType], null: false do
      argument :id, ID, required: true
    end

    def get_post_from_fixed_following(id:)
      Follower.where('friend_id = ?', id).map(&:user).map do |user|
        user.posts
      end.flatten
    end

    field :get_post_from_flux_following, [Types::PostType], null: false do
      argument :id, ID, required: true
    end

    def get_post_from_flux_following(id:)
      FluxFollower.where('flux_friend_id = ?', id).map(&:user).map do |user|
        user.posts
      end.flatten
    end

    field :like_count, Integer, null: true do
      argument :id, ID, required: true
    end

    field :top_flux, [Types::FluxFollowerType], null: false

    def top_flux
      FluxFollower.joins(:user).select('users.first_name', 'users.last_name', 'flux_followers.user_id', 'count(flux_followers.flux_friend_id)')
      .group('users.first_name', 'users.last_name', 'flux_followers.user_id')
      .order('count DESC')
      .limit(4)
    end
  end
end
