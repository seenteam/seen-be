module Types
  class LikeType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: true
    field :post_id, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

    field :like_count, Integer, null: true do
      argument :id, ID, required: true
    end
    def like_count(id:)
      Like.select('post_id, sum (post_id)').group('post_id').where('post_id = ?', id)
    end
  end
end
