module Types
  class PostType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: true
    field :content, String, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :likes, [Types::LikeType], null: true
    field :user, [Types::UserType], null: true
    field :user, Types::UserType, null: true
    field :like_count, Integer, null: true
  end
end
