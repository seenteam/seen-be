require 'rails_helper'

RSpec.describe 'followers', type: :request do
  before :each do
    @user1 = create(:user)
    @user2 = create(:user)
    @user3 = create(:user)
    @user4 = create(:user)
    @user5 = create(:user)


    @user1.flux_friends << @user2
    @user1.flux_friends << @user3
    @user1.flux_friends << @user4
    @user1.flux_friends << @user5

  end
  describe 'query: users_flux_followers' do
    it 'view all users followers' do

      string = <<~GQL
      query {
        usersFluxFollowers(id: "#{@user1.id}"){
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
      expect(json_response[:data][:usersFluxFollowers]).to be_an Array
      expect(json_response[:data][:usersFluxFollowers].count).to eq(4)
      expect(json_response[:data][:usersFluxFollowers].first).to have_key(:id)
      expect(json_response[:data][:usersFluxFollowers].first).to have_key(:userName)
      expect(json_response[:data][:usersFluxFollowers].first).to have_key(:firstName)
      expect(json_response[:data][:usersFluxFollowers].first).to have_key(:lastName)
    end
  end
end