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
		   it 'should be not valid if cvv length  not equal to 3' do
				payment.cvv=9876543
				expect(payment.valid?).to eq(false)
				payment.cvv=93
				expect(payment.valid?).to eq(false)

			end

			it 'should be not valid if cvv is not an integer' do
				payment.cvv="ascgsgsajjhs"
				expect(payment.valid?).to eq(false)
			end


				it 'is not valid for payment without card number' do
				payment.card_number=nil
				expect(payment.valid?).to eq(false)
			    end

			    it 'should be not valid if card_number length  not lesser than 12' do
				payment.card_number=9876543
				expect(payment.valid?).to eq(false)
				
			end

			   it 'should be not valid if card_number length  not greater than 12' do
			
				payment.card_number=987654398865443223456
				expect(payment.valid?).to eq(false)
			end

			it 'should be not valid if card number is not an integer' do
				payment.card_number="ascgsgsajjhs"
				expect(payment.valid?).to eq(false)
			end

				it 'is not valid for payment without expiry month' do
				payment.expiry_month=nil
				expect(payment.valid?).to eq(false)

			end

			it 'should be not valid if expiry month length  not greater than 2' do
				payment.expiry_month=9876
				expect(payment.valid?).to eq(false)
				
				
			end
				it 'should be not valid if expiry month length  not lesser than 2' do
				
				payment.expiry_month=9
				expect(payment.valid?).to eq(false)
			
			end
			it 'should be not valid if expiry month not greater than 0' do
				
				
				payment.expiry_month=00
				expect(payment.valid?).to eq(false)
				
			end
			it 'should be not valid if expiry month  greater than 12' do
				
				
			
				payment.expiry_month=13
				expect(payment.valid?).to eq(false)
			end

			it 'should be not valid if expiry month is not an integer' do
				payment.expiry_month="ascgsgsajjhs"
			    expect(payment.valid?).to eq(false)

			end

			it 'is not valid for payment without expiry year' do
				payment.expiry_year=nil
				expect(payment.valid?).to eq(false)
		    end

		    it 'should be not valid if expiry year length  not greater than 4' do
				payment.expiry_year=98769999
				expect(payment.valid?).to eq(false)
			
			end

			  it 'should be not valid if expiry year length  not lesser than 4' do
				
				payment.expiry_year=9
				expect(payment.valid?).to eq(false)
				
			end

			  it 'should be not valid if expiry year   not lesser than current year' do
				
				
				payment.expiry_year=1999
				expect(payment.valid?).to eq(false)
			end

			it 'should be not valid if expiry year is not an integer' do
				payment.expiry_year="ascgsgsajjhs"
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