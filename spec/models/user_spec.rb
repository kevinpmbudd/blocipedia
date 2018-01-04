require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create!(username: 'bloc', email: 'bloc@blocipedia.io', password: 'helloworld', password_confirmation: 'helloworld') }

  # shoulda tests for username
  it { should validate_presence_of(:username) }
  it { should validate_length_of(:username).is_at_least(1) }

  # shoulda tests for email
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_length_of(:email).is_at_least(3) }
  it { should allow_value("bloc@blocipedia.io").for(:email) }

  describe "attributes" do
    it "should have username and email attributes" do
      expect(user).to have_attributes(username: user.username, email: user.email)
    end
  end
end
