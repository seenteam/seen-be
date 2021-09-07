require 'rails_helper'

RSpec.describe 'followers', type: :request do
  describe 'query: users_followers' do
    it 'view all users followers' do
      user1 = create(:user)
      user2 = create(:user)
      user3 = create(:user)
      user4 = create(:user)

      user2.friends << user1
      user3.friends << user1
      user4.friends << user1

      string = <<~GQL
      query {
        userFollowing(id: "#{user1.id}"){
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
      expect(json_response[:data][:userFollowing]).to be_an Array
      expect(json_response[:data][:userFollowing].count).to eq(3)
      expect(json_response[:data][:userFollowing].first).to have_key(:id)
      expect(json_response[:data][:userFollowing].first).to have_key(:userName)
      expect(json_response[:data][:userFollowing].first).to have_key(:firstName)
      expect(json_response[:data][:userFollowing].first).to have_key(:lastName)
    end
  end
end
