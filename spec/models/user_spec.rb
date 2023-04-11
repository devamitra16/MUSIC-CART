require 'rails_helper'

RSpec.describe User, :type => :model do
	
	describe "Validations" do
   
  context 'while creating user' do
  	let(:user1){create :user}
  	let(:user2){build :user,email: ""}
  	let(:user3){build :user,password: ""}
    it "is not valid without a password" do
     expect(user3.valid?).to eq(false)
    end

    it "is not valid without an email" do
      expect(user2.valid?).to eq(false)
    end
  end
end
end