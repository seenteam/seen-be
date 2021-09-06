require 'rails_helper'

RSpec.describe 'users', type: :request do
  describe 'query: users' do
    it 'view all users' do
      create_list(:user, 5)
      string = <<~GQL
      query {
              users {
                id
                userName
                firstName
                lastName
                email
                phoneNumber
                birthday
              }
            }
      GQL

      post graphql_path, params: { query: string }
      json_response = JSON.parse(@response.body, symbolize_names: true)
    
      expect(json_response).to have_key(:data)
      expect(json_response[:data][:users]).to be_an Array
      expect(json_response[:data][:users].count).to eq(5)
      expect(json_response[:data][:users].first).to have_key(:id)
      expect(json_response[:data][:users].first).to have_key(:userName)
      expect(json_response[:data][:users].first).to have_key(:firstName)
      expect(json_response[:data][:users].first).to have_key(:lastName)
      expect(json_response[:data][:users].first).to have_key(:email)
      expect(json_response[:data][:users].first).to have_key(:phoneNumber)
      expect(json_response[:data][:users].first).to have_key(:birthday)
    end

    it 'can find user by id' do
      user_id = create(:user).id
      string = <<~GQL
      query {
              user (id: "#{user_id}") {
                id
                userName
                firstName
                lastName
                email
                phoneNumber
                birthday
              }
            }
      GQL

      post graphql_path, params: { query: string }
      json_response = JSON.parse(@response.body, symbolize_names: true)

      expect(json_response).to have_key(:data)
      expect(json_response[:data][:user]).to have_key(:id)
      expect(json_response[:data][:user]).to have_key(:userName)
      expect(json_response[:data][:user]).to have_key(:firstName)
      expect(json_response[:data][:user]).to have_key(:lastName)
      expect(json_response[:data][:user]).to have_key(:email)
      expect(json_response[:data][:user]).to have_key(:phoneNumber)
      expect(json_response[:data][:user]).to have_key(:birthday)
    end

  end
end
