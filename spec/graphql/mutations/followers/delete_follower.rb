require 'rails_helper'

RSpec.describe 'delete_post', type: :request do
  describe 'mutation: deletePost' do
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

      string = <<~GQL
        mutation {
          deleteFollower(input: {
            connectionId: "#{connection.id}"
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

      expect(json_response).to have_key(:data)
      expect(json_response[:data]).to have_key(:deletePost)
      expect(json_response[:data][:deletePost]).to have_key(:message)
      expect(json_response[:data][:deletePost][:message]).to be_a(String)

      expect(json_response[:data][:deletePost][:user]).to have_key(:id)
      expect(json_response[:data][:deletePost][:user]).to have_key(:userName)
      expect(json_response[:data][:deletePost][:user]).to have_key(:firstName)
      expect(json_response[:data][:deletePost][:user]).to have_key(:lastName)
      expect(json_response[:data][:deletePost][:user]).to have_key(:email)
      expect(json_response[:data][:deletePost][:user]).to have_key(:phoneNumber)
      expect(json_response[:data][:deletePost][:user]).to have_key(:birthday)

      json_response[:data][:deletePost][:user].each_value do |value|
        expect(value.class).to eq(String)
      end
    end
  end
end
