module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :update_user, mutation: Mutations::UpdateUser
    field :delete_user, mutation: Mutations::DeleteUser
    field :create_post, mutation: Mutations::CreatePost
    field :update_post, mutation: Mutations::UpdatePost
    field :delete_post, mutation: Mutations::DeletePost
    field :create_follower, mutation: Mutations::CreateFollower
    field :delete_follower, mutation: Mutations::DeleteFollower
    field :create_like, mutation: Mutations::CreateLike
    field :delete_like, mutation: Mutations::DeleteLike
  end
end
