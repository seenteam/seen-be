require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:posts) }
    it { should have_many(:likes) }
    it { should have_many(:followers) }
    it { should have_many(:flux_followers) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:birthday) }
    # it { should validate_numericality_of(:phone_number) } # need to fix this
    it { should validate_uniqueness_of(:user_name) }
    it { should validate_uniqueness_of(:email) }
  end

  describe 'class methods' do
    describe '.distribute' do

    end
  end
end
