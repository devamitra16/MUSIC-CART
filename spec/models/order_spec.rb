require 'rails_helper'

RSpec.describe Order, type: :model do
	describe 'Validations' do
		context 'While placing order' do
			let(:customer){create(:customer)}
		   let(:customer_user){create(:user, accountable: customer)}
		   let(:seller){create(:seller)}
		   let(:seller_user){create(:user, accountable: seller, email: "priya@gmail.com", password: "deva16")}
		   let(:cart){create(:cart, user: customer_user)}
		    let(:instrument) {create(:instrument,user: seller_user)}
			let(:order){build(:order,user: customer_user,cart: cart)}

            it 'is valid with all the params' do
            	expect(order.valid?).to eq(true)
            end
			
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
		    let(:customer){create(:customer)}
		    let(:customer_user){create(:user, accountable: customer)}
		    let(:seller){create(:seller)}
		    let(:seller_user){create(:user, accountable: seller, email: "seetha@gmail.com", password: "deva16")}
		    let(:cart){create(:cart, user: customer_user)}
		    let(:instrument) {create(:instrument,user: seller_user)}
			let(:order){build(:order,user: customer_user,cart: cart)}
			before do
				cart.instruments<<instrument
			end
		
        context 'line_items_present' do
        	it 'should check whether line_items_present before placing order' do
        		expect(cart.instruments.present?). to eq(true)
        	end
       end
	end

	describe 'Associations' do
		   let(:customer){create(:customer)}
		   let(:customer_user){create(:user, accountable: customer)}
		   let(:seller){create(:seller)}
		   let(:seller_user){create(:user, accountable: seller, email: "aishwarya@gmail.com", password: "deva16")}
		   let(:cart){create(:cart, user: customer_user)}
		    let(:instrument) {create(:instrument,user: seller_user)}
			let(:order){build(:order,user: customer_user,cart: cart)}


		it 'belongs to a user' do
			expect(order.user).to eq_to(customer_user)
		end
		
		it 'belongs to a cart' do
			expect(order.cart).to eq_to(cart)
		end
	end	
	


end