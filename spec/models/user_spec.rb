require 'rails_helper'

RSpec.describe User, type: :model do
  before do 
    @valid_user = User.create(email: "user@example.com", password: "123456")
    @invalid_user = User.create(email: "user1@example.com", password: "123")
  end

  describe "validates" do 
    it "it is valid attributes" do 
      expect(@valid_user).to be_valid
    end
    it "it is not valid attributes" do 
      expect(@invalid_user).not_to be_valid
    end

    it "is invalid with a non-unique email" do
      User.create(email: 'user@example.com', password: 'password123') # Create the first user with a valid email
      duplicate_user = User.create(email: 'user@example.com', password: 'password123')
      expect(duplicate_user).not_to be_valid
      expect(duplicate_user.errors[:email][0]).to include("has already been taken")
    end
  end
end
