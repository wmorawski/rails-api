require "rails_helper"

RSpec.describe User, type: :model do
  describe "#validations" do
    it "has valid factory" do
      user = build :user
      expect(user).to be_valid
    end

    it "validates presence of attributes" do
      user = build :user, login: nil, provider: nil
      expect(user).not_to be_valid
      expect(user.errors.messages[:login]).to include("can't be blank")
      expect(user.errors.messages[:provider]).to include("can't be blank")
    end

    it "validates the uniqueness of login" do
      first_user = create :user
      expect(first_user).to be_valid

      second_user = build :user, login: first_user.login
      expect(second_user).not_to be_valid
      expect(second_user.errors[:login]).to include("has already been taken")

      second_user.login = "newlogin"
      expect(second_user).to be_valid
    end
  end
end
