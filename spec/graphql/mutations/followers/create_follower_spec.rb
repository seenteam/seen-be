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
              errors
              followerId
            }
      }
      GQL

      post graphql_path, params: { query: string }
      json_response = JSON.parse(@response.body, symbolize_names: true)

      expect(json_response).to have_key(:data)
      expect(json_response[:data]).to have_key(:createFollower)
      expect(json_response[:data][:createFollower]).to have_key(:followerId)
      expect(json_response[:data][:createFollower]).to have_key(:errors)
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

    it 'cannot follow yourself' do
      follower = create(:user)
      user = create(:user)
      string = <<~GQL
        mutation {
          createFollower(input: {
            userId: "#{user.id}"
            friendId: "#{user.id}"
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
              errors
              followerId
            }
      }
      GQL

      post graphql_path, params: { query: string }
      json_response = JSON.parse(@response.body, symbolize_names: true)
      # binding.pry

      expect(json_response[:data][:createFollower]).to have_key(:followerInfo)
      expect(json_response[:data][:createFollower][:followerInfo]).to eq(nil)
      expect(json_response[:data][:createFollower][:userInfo]).to have_key(:id)
      expect(json_response[:data][:createFollower][:userInfo]).to have_key(:userName)
      expect(json_response[:data][:createFollower][:userInfo]).to have_key(:firstName)
      expect(json_response[:data][:createFollower][:userInfo]).to have_key(:lastName)
      expect(json_response[:data][:createFollower][:userInfo]).to have_key(:email)
      expect(json_response[:data][:createFollower][:userInfo]).to have_key(:phoneNumber)
      expect(json_response[:data][:createFollower][:userInfo]).to have_key(:birthday)
      expect(json_response[:data][:createFollower]).to have_key(:errors)
      expect(json_response[:data][:createFollower][:errors][0]).to eq("You cannot follow yourself")
      expect(json_response[:data][:createFollower]).to have_key(:followerId)
      expect(json_response[:data][:createFollower][:followerId]).to eq(0)

    end

    it 'cannot follow someone twice' do
      follower = create(:user)
      user = create(:user)
      first = <<~GQL
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
              errors
              followerId
            }
      }
      GQL

      post graphql_path, params: { query: first }
      json_response1 = JSON.parse(@response.body, symbolize_names: true)

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
              errors
              followerId
            }
      }
      GQL

      post graphql_path, params: { query: string }
      json_response = JSON.parse(@response.body, symbolize_names: true)

      expect(json_response[:data][:createFollower]).to have_key(:followerInfo)
      expect(json_response[:data][:createFollower][:followerInfo]).to eq(nil)
      expect(json_response[:data][:createFollower][:userInfo]).to have_key(:id)
      expect(json_response[:data][:createFollower][:userInfo]).to have_key(:userName)
      expect(json_response[:data][:createFollower][:userInfo]).to have_key(:firstName)
      expect(json_response[:data][:createFollower][:userInfo]).to have_key(:lastName)
      expect(json_response[:data][:createFollower][:userInfo]).to have_key(:email)
      expect(json_response[:data][:createFollower][:userInfo]).to have_key(:phoneNumber)
      expect(json_response[:data][:createFollower][:userInfo]).to have_key(:birthday)
      expect(json_response[:data][:createFollower]).to have_key(:errors)
      expect(json_response[:data][:createFollower][:errors][0]).to eq("You are already following #{follower.first_name} #{ follower.last_name}!")
      expect(json_response[:data][:createFollower]).to have_key(:followerId)
      expect(json_response[:data][:createFollower][:followerId]).to eq(0)
    end

  end
end
