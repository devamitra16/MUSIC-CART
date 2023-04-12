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

describe "Associations" do
  context "has many" do
    [:instruments, :orders, :payments].each do |sym|
      it sym.to_s.humanize do
        association = User.reflect_on_association(sym).macro
        expect(association).to be(:has_many)
      end
    end
  end
end 

end