require 'rails_helper'

RSpec.describe 'delete_like', type: :request do
  describe 'mutation: DeleteCreate' do
    it 'deletes a like' do
      user = create(:user)
      post = user.posts.create(content: Faker::ChuckNorris.fact)

      like = <<~GQL
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

      post graphql_path, params: { query: like }
      json_response1 = JSON.parse(@response.body, symbolize_names: true)
      like_id = json_response1[:data][:createLike][:like][:id]

      string = <<~GQL
        mutation {
          deleteLike(input: {
            likeId: "#{like_id.to_i}"
          }) {
              message
            }
      }
      GQL

      post graphql_path, params: { query: string }
      json_response = JSON.parse(@response.body, symbolize_names: true)

      expect(json_response).to have_key(:data)
      expect(json_response[:data]).to have_key(:deleteLike)
      expect(json_response[:data][:deleteLike]).to have_key(:message)
      expect(json_response[:data][:deleteLike][:message]).to eq("Like Removed")
    end
  end
end
