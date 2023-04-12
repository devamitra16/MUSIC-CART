require 'rails_helper'

RSpec.describe Cart, type: :model do
	describe 'Associations' do
		let(:user){build(:user)}
		let(:cart){create(:cart, user: user)}
		let(:instrument) {build(:instrument,user: user)}

		it 'belongs to a user' do
			expect(cart.user).to eq_to(user)
		end
	end	


  context "has many" do
    
        it 'should have has many association' do
        association = Cart.reflect_on_association(:orders).macro
        expect(association).to be(:has_many)
      
   end
  end

end