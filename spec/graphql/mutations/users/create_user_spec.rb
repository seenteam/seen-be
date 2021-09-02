require 'rails_helper'

RSpec.describe 'create_user', type: :request do
  describe 'mutation: userCreate' do
    it 'creates a user' do
      string = <<~GQL
        mutation {
          createUser(input: {
            userName: "ChrisPBacon",
            firstName: "Chris",
            lastName: "Bacon",
            phoneNumber: "123-123-1234",
            email: "example@example.com",
            birthday: "2013-07-16"
          }) {
            user {
              id
              userName
              firstName
              lastName
              email
              phoneNumber
              birthday
            }
          }
        }
      GQL

      post graphql_path, params: { query: string }
      json_response = JSON.parse(@response.body, symbolize_names: true)

      expect(json_response).to have_key(:data)
      expect(json_response[:data]).to have_key(:createUser)
      expect(json_response[:data][:createUser]).to have_key(:user)
      expect(json_response[:data][:createUser][:user]).to have_key(:id)
      expect(json_response[:data][:createUser][:user]).to have_key(:userName)
      expect(json_response[:data][:createUser][:user]).to have_key(:firstName)
      expect(json_response[:data][:createUser][:user]).to have_key(:lastName)
      expect(json_response[:data][:createUser][:user]).to have_key(:email)
      expect(json_response[:data][:createUser][:user]).to have_key(:phoneNumber)
      expect(json_response[:data][:createUser][:user]).to have_key(:birthday)

      json_response[:data][:createUser][:user].each_value do |value|
        expect(value.class).to eq(String)
      end
    end
  end
end
