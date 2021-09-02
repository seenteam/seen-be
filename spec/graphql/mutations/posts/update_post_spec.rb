require 'rails_helper'

RSpec.describe 'update_post', type: :request do
  describe 'mutation: updatePost' do
    it 'updates a post' do
      user = create(:user)
      post = user.posts.create(content: Faker::ChuckNorris.fact)
      string = <<~GQL
      mutation {
        updatePost(input: {
          content: "This is my new post!"
          postId: "#{post.id}"
        }) {
          post {
            content
            id
          }
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
      expect(json_response[:data]).to have_key(:updatePost)
      expect(json_response[:data][:updatePost]).to have_key(:post)
      expect(json_response[:data][:updatePost][:post]).to have_key(:content)
      expect(json_response[:data][:updatePost][:post][:content]).to eq('This is my new post!')
      expect(json_response[:data][:updatePost][:post]).to have_key(:id)
      json_response[:data][:updatePost][:post].each_value do |value|
        expect(value.class).to eq(String)
      end

      expect(json_response[:data][:updatePost][:user]).to have_key(:id)
      expect(json_response[:data][:updatePost][:user]).to have_key(:userName)
      expect(json_response[:data][:updatePost][:user]).to have_key(:firstName)
      expect(json_response[:data][:updatePost][:user]).to have_key(:lastName)
      expect(json_response[:data][:updatePost][:user]).to have_key(:email)
      expect(json_response[:data][:updatePost][:user]).to have_key(:phoneNumber)
      expect(json_response[:data][:updatePost][:user]).to have_key(:birthday)

      json_response[:data][:updatePost][:user].each_value do |value|
        expect(value.class).to eq(String)
      end
    end
  end
end
