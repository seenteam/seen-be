module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    # field :create_dog, mutation: Mutations::CreateDog
    # field :create_event, mutation: Mutations::CreateEvent
    # field :create_link, mutation: Mutations::CreateLink
  end
end

# 
# userName: "rcasias",
#     firstName: "Regina",
#     lastName: "Casias",
#     phoneNumber: "123-123-1234",
#     email: "r@email.com",
#     birthday: "2013-07-16"
