require 'rails_helper'

RSpec.describe WikiPolicy do
  subject { described_class.new(user, wiki) }

  let(:resolved_scope) do
    described_class::Scope.new(user, Wiki.all).resolve
  end

  let(:wiki) { create(:wiki) }

  context "guest user" do
    let(:user) { nil }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_actions([:new, :create, :edit, :update, :destroy]) }
  end

  context "for a standard user" do
    let(:user) { create(:user) }
    let(:wiki_private) { create(:wiki, private: true) }
    let(:wiki_public) { create(:wiki) }

    it 'excludes private wiki in resolved scope' do
      expect(resolved_scope).not_to include(wiki_private)
    end

    it 'includes public wiki in resolved scope' do
      expect(resolved_scope).to include(wiki_public)
    end

    it { is_expected.to permit_actions([:show, :new, :create, :edit, :update, :destroy]) }
  end

  context "for a premium user" do
    let(:user) { create(:user, role: "premium") }

    let(:wiki) { create(:wiki, private: true) }

    it 'includes wiki in resolved scope' do
      expect(resolved_scope).to include(wiki)
    end

    it { is_expected.to permit_actions([:show, :new, :create, :edit, :update, :destroy]) }
  end

  context "for an admin user" do
    let(:user) { create(:user, role: "admin") }

    let(:wiki) { create(:wiki, private: true) }

    it 'includes wiki in resolved scope' do
      expect(resolved_scope).to include(wiki)
    end

    it { is_expected.to permit_actions([:show, :new, :create, :edit, :update, :destroy]) }
  end
end
