require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:content) }
  end

  describe 'like_count' do
    it 'counts the likes a post has' do
      user1 = create(:user)
      user2 = create(:user)
      user3 = create(:user)
      user4 = create(:user)

      post = Post.create!(user_id: user1.id, content: 'post1')

      post.likes.create(user_id: user2.id)
      post.likes.create(user_id: user3.id)
      post.likes.create(user_id: user4.id)

      expect(post.like_count).to eq(3)
    end
  end
end
