module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :user_name, String, null: true
    field :first_name, String, null: true
    field :last_name, String, null: true
    field :email, String, null: true
    field :phone_number, String, null: true
    field :birthday, GraphQL::Types::ISO8601DateTime, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :posts, [Types::PostType], null: true
    field :followers, [Types::FollowerType], null: true
    field :likes, [Types::LikeType], null: true
    field :count, Integer, null: false
  end
end
