class Mutations::DeleteUser < Mutations::BaseMutation
  argument :user_id, ID, required: true

  field :message, String, null: false
  field :errors, [String], null: false

  def resolve(user_id:)
    user = User.find(user_id)
    if user.destroy
      {
        message: "Account Deleted!",
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
