require 'rails_helper'

RSpec.describe 'get_post_from_flux_following', type: :request do
  describe 'query: get_post_from_flux_following' do
    it 'view all posts from users flux_following' do

      user1 = create(:user)
      user2 = create(:user)

      5.times do
        user2.posts.create(content: Faker::ChuckNorris.fact)
      end

      user2.flux_friends << user1

      string = <<~GQL
      query {
        getPostFromFluxFollowing(id: "#{user1.id}") {
            		id
                userId
            		content
              }
            }
      GQL

      post graphql_path, params: { query: string }
      json_response = JSON.parse(@response.body, symbolize_names: true)

      expect(json_response).to have_key(:data)
      expect(json_response[:data][:getPostFromFluxFollowing]).to be_an Array
      expect(json_response[:data][:getPostFromFluxFollowing].count).to eq(5)
      expect(json_response[:data][:getPostFromFluxFollowing].first).to have_key(:id)
      expect(json_response[:data][:getPostFromFluxFollowing].first).to have_key(:userId)
      expect(json_response[:data][:getPostFromFluxFollowing].first).to have_key(:content)
    end
  end
end
