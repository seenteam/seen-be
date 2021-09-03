require 'rails_helper'

RSpec.describe 'delete_follower', type: :request do
  describe 'mutation: deleteFollower' do
    it 'deletes a post' do
      user = create(:user)
      follower = create(:user)

      connection = <<~GQL
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

      post graphql_path, params: { query: connection }
      json_response1 = JSON.parse(@response.body, symbolize_names: true)

      follower_id = json_response1[:data][:createFollower][:follower][:id]

      string = <<~GQL
        mutation {
          deleteFollower(input: {
            connectionId: "#{follower_id.to_i}"
          }) {
            message
          }
      }
      GQL
      post graphql_path, params: { query: string }
      json_response = JSON.parse(@response.body, symbolize_names: true)

      expect(json_response).to have_key(:data)
      expect(json_response[:data]).to have_key(:deleteFollower)
      expect(json_response[:data][:deleteFollower]).to have_key(:message)
      expect(json_response[:data][:deleteFollower][:message]).to eq("Your connection has been deleted!")

    end
  end
end
