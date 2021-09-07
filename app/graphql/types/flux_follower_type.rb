module Types
  class FluxFollowerType < Types::BaseObject
    field :id, ID, null: false
    field :user_id, Integer, null: true
    field :flux_friend_id, Integer, null: true
    field :created_at, GraphQL::Types::ISO8601DateTime, null: true
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: true
    field :count, Integer, null: true
    field :user, Types::UserType, null: true
  end
end
