require 'rails_helper'

RSpec.describe 'delete_user', type: :request do
  describe 'mutation: deleteUser' do
    it 'deletes a user' do
      user = create(:user)
      string = <<~GQL
        mutation {
          deleteUser(input: {
            userId: #{user.id}
          }) {
            message
          }
        }
      GQL

      post graphql_path, params: { query: string }
      json_response = JSON.parse(@response.body, symbolize_names: true)

      expect(json_response).to have_key(:data)
      expect(json_response[:data]).to have_key(:deleteUser)
      expect(json_response[:data][:deleteUser]).to have_key(:message)
      expect(json_response[:data][:deleteUser][:message]).to be_a(String)
    end
  end
end
