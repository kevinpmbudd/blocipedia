require 'rails_helper'

RSpec.describe WikiPolicy do
  subject { described_class.new(user, wiki) }

  let(:wiki) { create(:wiki) }

  context "guest user" do
    let(:user) { nil }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_actions([:new, :create, :edit, :update, :destroy]) }
  end

  context "for a standard user" do
    let(:user) { create(:user) }

    it { is_expected.to permit_actions([:show, :new, :create, :edit, :update, :destroy]) }
  end

  context "for an admin user" do
    let(:user) { create(:user) }

    it { is_expected.to permit_actions([:show, :new, :create, :edit, :update, :destroy]) }
  end
end
