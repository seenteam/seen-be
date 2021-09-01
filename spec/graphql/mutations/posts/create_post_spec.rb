require 'rails_helper'

RSpec.describe 'create_post', type: :request do
  describe 'mutation: postCreate' do
    it 'creates a post' do
      user = create(:user)
      string = <<~GQL
        mutation {
          createPost(input: {
            content: "This is my post!"
            userId: "#{user.id}"
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
      expect(json_response[:data]).to have_key(:createPost)
      expect(json_response[:data][:createPost]).to have_key(:post)
      expect(json_response[:data][:createPost][:post]).to have_key(:content)
      expect(json_response[:data][:createPost][:post]).to have_key(:id)

      json_response[:data][:createPost][:post].each_value do |value|
        expect(value.class).to eq(String)
      end

      expect(json_response[:data][:createPost][:user]).to have_key(:id)
      expect(json_response[:data][:createPost][:user]).to have_key(:userName)
      expect(json_response[:data][:createPost][:user]).to have_key(:firstName)
      expect(json_response[:data][:createPost][:user]).to have_key(:lastName)
      expect(json_response[:data][:createPost][:user]).to have_key(:email)
      expect(json_response[:data][:createPost][:user]).to have_key(:phoneNumber)
      expect(json_response[:data][:createPost][:user]).to have_key(:birthday)

      json_response[:data][:createPost][:user].each_value do |value|
        expect(value.class).to eq(String)
      end
    end
  end
end
