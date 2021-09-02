require 'rails_helper'

RSpec.describe 'update_user', type: :request do
  describe 'mutation: updateUser' do
    it 'updates a user' do
      user = create(:user)
      string = <<~GQL
        mutation {
          updateUser(input: {
            userId: "#{user.id}"
            userName: "Newusername"
            firstName: "UpdatedFirstName"
            lastName: "UpdatedLastName"
            phoneNumber: "987-654-3210"
            email: "NEWemail@email.com"
            birthday: "2013-07-16"
          }) {
            user {
              id
              userName
              firstName
              lastName
              phoneNumber
              email
              birthday
          }
         }
        }
      GQL

      post graphql_path, params: { query: string }
      json_response = JSON.parse(@response.body, symbolize_names: true)

      expect(json_response).to have_key(:data)
      expect(json_response[:data]).to have_key(:updateUser)
      expect(json_response[:data][:updateUser]).to have_key(:user)
      expect(json_response[:data][:updateUser][:user]).to have_key(:id)
      expect(json_response[:data][:updateUser][:user]).to have_key(:userName)
      expect(json_response[:data][:updateUser][:user]).to have_key(:firstName)
      expect(json_response[:data][:updateUser][:user]).to have_key(:lastName)
      expect(json_response[:data][:updateUser][:user]).to have_key(:email)
      expect(json_response[:data][:updateUser][:user]).to have_key(:phoneNumber)
      expect(json_response[:data][:updateUser][:user]).to have_key(:birthday)

      expect(json_response[:data][:updateUser][:user][:userName]).to eq('Newusername')
      expect(json_response[:data][:updateUser][:user][:firstName]).to eq('UpdatedFirstName')
      expect(json_response[:data][:updateUser][:user][:lastName]).to eq('UpdatedLastName')
      expect(json_response[:data][:updateUser][:user][:email]).to eq('NEWemail@email.com')
      expect(json_response[:data][:updateUser][:user][:phoneNumber]).to eq('987-654-3210')

      json_response[:data][:updateUser][:user].each_value do |value|
        expect(value.class).to eq(String)
      end
    end
  end
end
