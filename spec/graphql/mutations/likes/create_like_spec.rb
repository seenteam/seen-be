require 'rails_helper'

RSpec.describe 'create_like', type: :request do
  describe 'mutation: LikeCreate' do
    it 'creates a follower' do
      user = create(:user)
      post = user.posts.create(content: Faker::ChuckNorris.fact)
      string = <<~GQL
        mutation {
          createLike(input: {
            userId: "#{user.id}"
            postId: "#{post.id}"
          }) {
              like {
                id
              }
              user {
                id
          		}
              post{
                id
          		}
            }
      }
      GQL

      post graphql_path, params: { query: string }
      json_response = JSON.parse(@response.body, symbolize_names: true)
      
      expect(json_response).to have_key(:data)
      expect(json_response[:data][:createLike]).to have_key(:like)
      expect(json_response[:data][:createLike]).to have_key(:user)
      expect(json_response[:data][:createLike]).to have_key(:post)
    end
  end
end
