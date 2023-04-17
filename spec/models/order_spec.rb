require 'rails_helper'

RSpec.describe Order, type: :model do
	describe 'Validations' do
		context 'While placing order' do
			
			let(:order){build(:order)}

			
			it 'is not valid for order without address' do
                
				order.address=nil
				expect(order.valid?).to eq(false)
			end


			it 'should be not valid if address length not greater than 1000' do
				order.address="coimbatore"*1000
				expect(order.valid?).to eq(false)
			end

			

			it 'is not valid for order without contactnumber' do
				order.contact_number=nil
				expect(order.valid?).to eq(false)

			end

		    it 'should be not valid if contact_number length  greater than 10' do
				order.contact_number=987654321235
				expect(order.valid?).to eq(false)
			end

			it 'should be not valid if contact_number is not a integer' do
				order.contact_number="ascgsgsajjhs"
				expect(order.valid?).to eq(false)
			end


			


		end
	end

	describe 'Callbacks' do
		let(:user){create(:user)}
		let(:order){create(:order,user: user)}
		let(:cart){create(:cart,user: user)}
		context 'destroy_line_items' do
        it 'should destroy line_items after placing order'do
        expect(cart.line_items.empty?).to eq(true)
        end
       end
	end

	describe 'Associations' do
		let(:user){build(:user)}
		let(:cart){create(:cart, user: user)}
		let(:order) {build(:order,user: user,cart: cart)}


		it 'belongs to a user' do
			expect(order.user).to eq_to(user)
		end
		
		it 'belongs to a cart' do
			expect(order.cart).to eq_to(cart)
		end
	end	
	


end