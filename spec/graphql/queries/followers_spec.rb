require 'rails_helper'

RSpec.describe 'followers', type: :request do
  before :each do
    @user1 = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)
    @user4 = create(:user)
    @user5 = create(:user)


    @user1.friends << @user2
    @user1.friends << @user3
    @user1.friends << @user4
    @user1.friends << @user5

  end
  describe 'query: users_followers' do
    it 'view all users followers' do

      string = <<~GQL
      query {
        usersFollowers(id: "#{@user1.id}"){
          id
          userName
          firstName
          lastName
        }
      }
      GQL

      post graphql_path, params: { query: string }
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to have_key(:data)
      expect(json_response[:data][:usersFollowers]).to be_an Array
      expect(json_response[:data][:usersFollowers].count).to eq(4)
      expect(json_response[:data][:usersFollowers].first).to have_key(:id)
      expect(json_response[:data][:usersFollowers].first).to have_key(:userName)
      expect(json_response[:data][:usersFollowers].first).to have_key(:firstName)
      expect(json_response[:data][:usersFollowers].first).to have_key(:lastName)
    end
  end
  describe 'query: followers' do
    it 'returns all followers' do
      @user2.friends << @user1
      @user2.friends << @user3
      @user2.friends << @user4
      @user2.friends << @user5

      string = <<~GQL
      query {
        followers{
          id
          userId
          friendId
        }
      }
      GQL

      post graphql_path, params: { query: string }
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to have_key(:data)
      expect(json_response[:data][:followers]).to be_an Array
      expect(json_response[:data][:followers].count).to eq(8)
      expect(json_response[:data][:followers].first).to have_key(:id)
      expect(json_response[:data][:followers].first).to have_key(:userId)
      expect(json_response[:data][:followers].first).to have_key(:friendId)
    end
  end
  describe 'query: follower' do
    it 'returns a follower by id' do

      string = <<~GQL
      query {
        follower(id: "#{@user1.followers.first.id}"){
          id
          userId
          friendId
        }
      }
      GQL

      post graphql_path, params: { query: string }
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to have_key(:data)
      expect(json_response[:data][:follower]).to be_a Hash
      expect(json_response[:data][:follower]).to have_key(:id)
      expect(json_response[:data][:follower]).to have_key(:userId)
      expect(json_response[:data][:follower]).to have_key(:friendId)
    end
  end
end
