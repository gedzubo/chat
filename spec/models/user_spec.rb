require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#display_name" do
    context "when name is present" do
      let(:user) { create(:user, name: "Alice") }

      it "returns the display name" do
        expect(user.display_name).to eq("Alice (##{user.id})")
      end
    end

    context "when name is not present" do
      let(:user) { create(:user, name: nil) }

      it "returns nil" do
        expect(user.display_name).to be_nil
      end
    end
  end
end
