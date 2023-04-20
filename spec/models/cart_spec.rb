require 'rails_helper'

RSpec.describe Cart, type: :model do
	describe 'Associations' do
		let(:customer){create(:customer)}
		let(:customer_user){create(:user, accountable: customer)}
		let(:seller){create(:seller)}
		let(:seller_user){create(:user, accountable: seller, email: "aishukarthik@gmail.com", password: "deva16")}
		let(:cart){create(:cart, user: customer_user)}
		let(:instrument) {create(:instrument,user: seller_user)}

		it 'belongs to a user' do
			expect(cart.user).to eq_to(customer_user)
		end
	end	


    context "has many" do
    
        it 'should have has many association' do
        association = Cart.reflect_on_association(:orders).macro
        expect(association).to be(:has_many)
      
   end
  end

end