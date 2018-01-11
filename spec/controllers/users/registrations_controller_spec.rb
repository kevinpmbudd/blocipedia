require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  let(:user) { create(:user) }

  context "premium user" do
    before do
      sign_in user
      user.premium!
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    describe "POST downgrade" do
      it "updates the users role to standard" do
        expect{ post :downgrade }.to change { user.role }.to("standard")
      end

      it ":back redirects to user profile page" do
        post :downgrade
        expect(response).to redirect_to(edit_user_registration_path)
      end
    end
  end
end
