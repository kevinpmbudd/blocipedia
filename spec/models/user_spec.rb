require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  let(:user_with_invalid_username) { build(:user, username: "") }
  let(:user_with_invalid_email) { build(:user, email: "") }

  it { should validate_presence_of(:username) }
  it { should validate_length_of(:username).is_at_least(1) }

  # it { should have_many(:wikis) }

  it { should have_many(:wikis).through(:collaborators) }

  describe "attributes" do
    it "should have username and email attributes" do
      expect(user).to have_attributes(username: user.username, email: user.email)
    end

    it "responds to role" do
      expect(user).to respond_to(:role)
    end

    it "responds to standard?" do
      expect(user).to respond_to(:standard?)
    end

    it "responds to premium?" do
      expect(user).to respond_to(:premium?)
    end

    it "responds to admin?" do
      expect(user).to respond_to(:admin?)
    end
  end

  describe "roles" do
    it "is standard by default" do
      expect(user.role).to eql("standard")
    end

    context "standard user" do
      it "returns true for #standard?" do
        expect(user.standard?).to be_truthy
      end

      it "returns false for #premium?" do
        expect(user.premium?).to be_falsey
      end

      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end
    end

    context "premium user" do
      before do
        user.premium!
      end

      it "returns true for #premium?" do
        expect(user.premium?).to be_truthy
      end

      it "returns false for #standard?" do
        expect(user.standard?).to be_falsey
      end

      it "returns false for #admin?" do
        expect(user.admin?).to be_falsey
      end
    end

    context "admin user" do
      before do
        user.admin!
      end

      it "returns true for #admin?" do
        expect(user.admin?).to be_truthy
      end

      it "returns false for #premium?" do
        expect(user.premium?).to be_falsey
      end

      it "returns false for #standard?" do
        expect(user.standard?).to be_falsey
      end
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
