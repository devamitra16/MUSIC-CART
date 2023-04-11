require 'rails_helper'

RSpec.describe Payment, type: :model do
	describe 'Validations' do
		context 'While making payment' do
			let(:user){create(:user)}
			let(:cart){create(:cart,user: user)}
			let(:order){create(:order,user: user,cart: cart)}
			
			let(:payment){create(:payment,user: user,order: order)}

			
			it 'is not valid for payment without cvv' do
				payment.cvv=nil
				expect(payment.valid?).to eq(false)
			end

			it 'is not valid for payment without name' do
				payment.name_on_the_card=nil
				expect(payment.valid?).to eq(false)

			end


				it 'is not valid for payment without card number' do
				payment.card_number=nil
				expect(payment.valid?).to eq(false)
			    end

				it 'is not valid for payment without expiry month' do
				payment.expiry_month=nil
				expect(payment.valid?).to eq(false)

			end

			it 'is not valid for payment without expiry year' do
				payment.expiry_year=nil
				expect(payment.valid?).to eq(false)
		    end
		 end
	end
	describe 'Associations' do
		let(:user){build(:user)}
		let(:cart){create(:cart, user: user)}
		let(:order) {build(:order,user: user,cart: cart)}
		let(:payment){create(:payment,user: user,order: order)}


		it 'belongs to a user' do
			expect(payment.user).to eq_to(user)
		end
		
		it 'belongs to a order' do
			expect(payment.order).to eq_to(order)
		end
	end	
	
end