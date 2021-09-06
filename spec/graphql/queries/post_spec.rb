require 'rails_helper'

RSpec.describe 'post', type: :request do
  describe 'query: posts' do
    it 'view all post' do

      user = create(:user)

      5.times do
        user.posts.create(content: Faker::ChuckNorris.fact)
      end

      string = <<~GQL
      query {
              posts {
            		id
                userId
            		content
              }
            }
      GQL

      post graphql_path, params: { query: string }
      json_response = JSON.parse(@response.body, symbolize_names: true)

      expect(json_response).to have_key(:data)
      expect(json_response[:data][:posts]).to be_an Array
      expect(json_response[:data][:posts].count).to eq(5)
      expect(json_response[:data][:posts].first).to have_key(:id)
      expect(json_response[:data][:posts].first).to have_key(:userId)
      expect(json_response[:data][:posts].first).to have_key(:content)
    end

    it 'can find post by id' do
      user = create(:user)
      post_id = user.posts.create(content: Faker::ChuckNorris.fact).id

      string = <<~GQL
          {
              post (id: #{post_id}) {
            		id
                userId
            		content
              }
            }
      GQL

      post graphql_path, params: { query: string }
      json_response = JSON.parse(@response.body, symbolize_names: true)

      expect(json_response).to have_key(:data)
      expect(json_response[:data][:post]).to have_key(:id)
      expect(json_response[:data][:post]).to have_key(:userId)
      expect(json_response[:data][:post]).to have_key(:content)
    end

    describe 'query: posts' do
      before :each do
        user = create(:user)
        user1 = create(:user)
        user2 = create(:user)
        user3 = create(:user)
        user4 = create(:user)

        post_id = user.posts.create(content: Faker::ChuckNorris.fact).id

        string = <<~GQL
        mutation {
                    createLike(input: {
                    userId: "#{user1.id}"
                    postId: "#{post_id}"
                              }) {
                    like {
                      id
                    }
                    user {
                      id
                    }
                    post {
                      id
                      content
                    }
                 }
              }
        GQL

        post graphql_path, params: { query: string }
        json_response = JSON.parse(@response.body, symbolize_names: true)

        string2 = <<~GQL
        mutation {
                    createLike(input: {
                    userId: "#{user1.id}"
                    postId: "#{post_id}"
                              }) {
                    like {
                      id
                    }
                    user {
                      id
                    }
                    post {
                      id
                      content
                    }
                 }
              }
        GQL

        post graphql_path, params: { query: string2 }
        json_response2 = JSON.parse(@response.body, symbolize_names: true)

        string3 = <<~GQL
        mutation {
                    createLike(input: {
                    userId: "#{user3.id}"
                    postId: "#{post_id}"
                              }) {
                    like {
                      id
                    }
                    user {
                      id
                    }
                    post {
                      id
                      content
                    }
                 }
              }
        GQL

        post graphql_path, params: { query: string3 }
        json_response3 = JSON.parse(@response.body, symbolize_names: true)

        string4 = <<~GQL
        mutation {
                    createLike(input: {
                    userId: "#{user4.id}"
                    postId: "#{post_id}"
                              }) {
                    like {
                      id
                    }
                    user {
                      id
                    }
                    post {
                      id
                      content
                    }
                 }
              }
        GQL

        post graphql_path, params: { query: string4 }
        json_response4 = JSON.parse(@response.body, symbolize_names: true)

        string5 = <<~GQL
        query {
                postLikes(id: "#{post_id}"){
                  id
                  userName
                  firstName
                  lastName
              	}
              }
        GQL

        post graphql_path, params: { query: string5 }
        @json_response5 = JSON.parse(@response.body, symbolize_names: true)
      end

      it 'can see how many likes a post has' do
        expect(@json_response5).to have_key(:data)
        expect(@json_response5[:data]).to have_key(:postLikes)
        expect(@json_response5[:data][:postLikes]).to be_an Array
        expect(@json_response5[:data][:postLikes].count).to eq(4)
        expect(@json_response5[:data][:postLikes].first).to have_key(:id)
        expect(@json_response5[:data][:postLikes].first).to have_key(:userName)
        expect(@json_response5[:data][:postLikes].first).to have_key(:firstName)
        expect(@json_response5[:data][:postLikes].first).to have_key(:lastName)
      end
    end

  end
end
