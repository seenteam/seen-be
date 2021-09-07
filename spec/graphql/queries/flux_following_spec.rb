require 'rails_helper'

RSpec.describe 'user_flux_following', type: :request do
  before :each do
    @user1 = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)
    @user4 = create(:user)
    @user5 = create(:user)


    @user2.flux_friends << @user1
    @user3.flux_friends << @user1
    @user4.flux_friends << @user1
    @user5.flux_friends << @user1

  end
  describe 'query: users_followers' do
    it 'view all users followers' do

      string = <<~GQL
      query {
        userFluxFollowing(id: "#{@user1.id}"){
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
      expect(json_response[:data][:userFluxFollowing]).to be_an Array
      expect(json_response[:data][:userFluxFollowing].count).to eq(4)
      expect(json_response[:data][:userFluxFollowing].first).to have_key(:id)
      expect(json_response[:data][:userFluxFollowing].first).to have_key(:userName)
      expect(json_response[:data][:userFluxFollowing].first).to have_key(:firstName)
      expect(json_response[:data][:userFluxFollowing].first).to have_key(:lastName)
    end
  end
end
