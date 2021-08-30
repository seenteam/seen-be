require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:posts) }
    it { should have_many(:likes) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:birthday) }
    # it { should validate_numericality_of(:phone_number) }
    it { should validate_uniqueness_of(:user_name) }
    it { should validate_uniqueness_of(:email) }
  end
end
