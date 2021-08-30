class Mutations::UpdateUser < Mutations::BaseMutation
  argument :user_id, ID, required: true
  argument :user_name, String, required: true
  argument :first_name, String, required: true
  argument :last_name, String, required: true
  argument :birthday, GraphQL::Types::ISO8601DateTime, required: true
  argument :email, String, required: true
  argument :phone_number, String, required: false

  field :user, Types::UserType, null: false
  field :errors, [String], null: false

  def resolve(user_id:, user_name:, first_name:, last_name:, birthday:, email:, phone_number:)
    user = User.find(user_id)
    if user.update(user_name: user_name, first_name: first_name, last_name: last_name, birthday: birthday, email: email, phone_number: phone_number)
      {
        user: user,
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
