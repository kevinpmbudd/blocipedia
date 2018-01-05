require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:user_with_invalid_username) { build(:user, username: "") }
  let(:user_with_invalid_email) { build(:user, email: "") }

  it { should validate_presence_of(:username) }
  it { should validate_length_of(:username).is_at_least(1) }

  it { should have_many(:wikis) }

  describe "attributes" do
    it "should have username and email attributes" do
      expect(user).to have_attributes(username: user.username, email: user.email)
    end
  end

  describe "invalid user" do
    it "should be an invalid user due to blank username" do
      expect(user_with_invalid_username).to_not be_valid
    end

    it "should be an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end
  end
end
