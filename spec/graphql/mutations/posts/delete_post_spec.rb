require 'rails_helper'

RSpec.describe 'delete_post', type: :request do
  describe 'mutation: deletePost' do
    it 'deletes a post' do
      user = create(:user)
      post = user.posts.create(content: Faker::ChuckNorris.fact)
      string = <<~GQL
        mutation {
          deletePost(input: {
            postId: "#{post.id}"
          }) {
            message
            user {
              id
              userName
              firstName
              lastName
              email
              phoneNumber
              birthday
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
