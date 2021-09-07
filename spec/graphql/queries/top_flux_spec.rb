require 'rails_helper'

RSpec.describe 'top_flux', type: :request do
  describe 'query: top_flux' do
    it 'returs users with largest flux followings' do
      10.times do
        create(:user)
      end

      FluxFollower.distribute

      string = <<~GQL
      query {
          topFlux{
            userId
            user{
              firstName
              lastName
            }
            count
          }
            }
      GQL

      post graphql_path, params: { query: string }
      json_response = JSON.parse(@response.body, symbolize_names: true)

      expect(json_response).to have_key(:data)
      expect(json_response[:data][:topFlux]).to be_an Array
      expect(json_response[:data][:topFlux].count).to eq(4)
      expect(json_response[:data][:topFlux].first).to have_key(:userId)
      expect(json_response[:data][:topFlux].first).to have_key(:user)
      expect(json_response[:data][:topFlux].first).to have_key(:count)
      expect(json_response[:data][:topFlux].first[:user]).to be_a(Hash)
      expect(json_response[:data][:topFlux].first[:user]).to have_key(:firstName)
      expect(json_response[:data][:topFlux].first[:user]).to have_key(:lastName)
      expect(json_response[:data][:topFlux].first[:user]).to have_key(:lastName)
    end
  end
end
