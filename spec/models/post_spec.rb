require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:content) }
  end
end