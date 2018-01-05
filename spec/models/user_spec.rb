require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  # shoulda tests for username
  it { should validate_presence_of(:username) }
  it { should validate_length_of(:username).is_at_least(1) }

  describe "attributes" do
    it "should have username and email attributes" do
      expect(user).to have_attributes(username: user.username, email: user.email)
    end
  end
end
