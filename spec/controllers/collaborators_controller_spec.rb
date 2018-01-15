require 'rails_helper'

RSpec.describe CollaboratorsController, type: :controller do
  let(:premium_user) { create(:user, role: "premium") }
  let(:standard_user) { create(:user) }
  let(:private_wiki) { create(:wiki, user_id: premium_user.id, private: true) }

  context "premium user" do
    before do
      sign_in premium_user
    end

    describe "POST create" do
      it "adds a collaborator (standard user) to a private wiki" do
        expect { post :create, params: { user_ids: [standard_user.id], wiki_id: private_wiki.id } }.to change(Collaborator,:count).by(1)
      end

      it "adds the correct user as a collaborator" do
        post :create, params: { user_ids: [standard_user.id], wiki_id: private_wiki.id }
        expect(private_wiki.users.first).to eq (standard_user)
      end

      it "removes all collaborators when none are selected for the wiki" do
        post :create, params: { user_ids: [standard_user.id], wiki_id: private_wiki.id }
        expect(Collaborator.count).to eq 1
        post :create, params: { user_ids: [], wiki_id: private_wiki.id }
        expect(Collaborator.count).to eq 0
      end

      it "redirects to the wiki show view" do
        post :create, params: { user_ids: [standard_user.id], wiki_id: private_wiki.id }
        expect(response).to redirect_to(private_wiki)
      end
    end
  end
end
