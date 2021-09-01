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
      # binding.pry
      Follower.where('user_id = ?', id).map(&:user)
    end

    # def followers_data(id:)
    #   User.find(users_followers(id:).friend_id.each do |follower|
    #     follower)
    #   end
    # end

  end
end
