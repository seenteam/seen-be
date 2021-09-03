require 'rails_helper'

RSpec.describe 'create_follower', type: :request do
  describe 'mutation: followerCreate' do
    it 'creates a follower' do
      follower = create(:user)
      user = create(:user)
      string = <<~GQL
        mutation {
          createFollower(input: {
            userId: "#{user.id}"
            friendId: "#{follower.id}"
          }) {
              followerInfo {
                id
                userName
                firstName
                lastName
                email
                phoneNumber
                birthday
              }
              userInfo {
                id
                userName
                firstName
                lastName
                email
                phoneNumber
                birthday
          		}
              follower{
                id
          		}
            }
      }
      GQL

      post graphql_path, params: { query: string }
      json_response = JSON.parse(@response.body, symbolize_names: true)

      # binding.pry
      expect(json_response).to have_key(:data)
      expect(json_response[:data]).to have_key(:createFollower)
      expect(json_response[:data][:createFollower]).to have_key(:followerInfo)
      expect(json_response[:data][:createFollower][:followerInfo]).to have_key(:id)
      expect(json_response[:data][:createFollower][:followerInfo]).to have_key(:userName)
      expect(json_response[:data][:createFollower][:followerInfo]).to have_key(:firstName)
      expect(json_response[:data][:createFollower][:followerInfo]).to have_key(:lastName)
      expect(json_response[:data][:createFollower][:followerInfo]).to have_key(:email)
      expect(json_response[:data][:createFollower][:followerInfo]).to have_key(:birthday)
      expect(json_response[:data][:createFollower][:followerInfo]).to have_key(:phoneNumber)
      expect(json_response[:data][:createFollower]).to have_key(:userInfo)
      expect(json_response[:data][:createFollower][:userInfo]).to have_key(:id)
      expect(json_response[:data][:createFollower][:userInfo]).to have_key(:userName)
      expect(json_response[:data][:createFollower][:userInfo]).to have_key(:firstName)
      expect(json_response[:data][:createFollower][:userInfo]).to have_key(:lastName)
      expect(json_response[:data][:createFollower][:userInfo]).to have_key(:email)
      expect(json_response[:data][:createFollower][:userInfo]).to have_key(:birthday)
      expect(json_response[:data][:createFollower][:userInfo]).to have_key(:phoneNumber)

      json_response[:data][:createFollower][:followerInfo].each_value do |value|
        expect(value.class).to eq(String)
      end
      json_response[:data][:createFollower][:userInfo].each_value do |value|
        expect(value.class).to eq(String)
      end
    end
  end
end
