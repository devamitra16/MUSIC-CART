require 'rails_helper'

RSpec.describe Instrument, type: :model do
	describe 'Validations' do
		context 'While creating instrument' do
			let(:user){create(:user)}
			
			let(:instrument){create(:instrument,user: user)}

			
			it 'is not valid for instrument without title' do
				instrument.title=nil
				expect(instrument.valid?).to eq(false)
			end
			it 'is valid with instrument title' do
				instrument.title="PRS"
				expect(instrument.valid?).to eq(true)
			end

			it 'is not valid for instrument without brand' do
				instrument.brand=nil
				expect(instrument.valid?).to eq(false)

			end
			it 'is valid with instrument brand' do
				instrument.brand="tobenz"
				expect(instrument.valid?).to eq(true)
			end

				it 'is not valid for instrument without price' do
				instrument.price=nil
				expect(instrument.valid?).to eq(false)

			end
			it 'is valid with instrument price' do
				instrument.price=2000
				expect(instrument.valid?).to eq(true)
			end

				it 'is not valid for instrument without color' do
				instrument.color=nil
				expect(instrument.valid?).to eq(false)

			end
			it 'is valid with instrument price' do
				instrument.color="black"
				expect(instrument.valid?).to eq(true)
			end
				it 'is not valid for instrument without model' do
				instrument.model=nil
				expect(instrument.valid?).to eq(false)

			end
			it 'is valid with instrument model' do
				instrument.model="vikatran"
				expect(instrument.valid?).to eq(true)
			end

			it 'should be not valid if title length not greater than 30' do
				instrument.title="assbdnsjkddmdjjwmdnwkjdmxsksmxlsmmsajwksmmsmkwndmamws"
				expect(instrument.valid?).to eq(false)
			end
			it 'should be valid if title length not greater than 30' do
				instrument.title="guitar"
				expect(instrument.valid?).to eq(true)
			end

			it 'should be price length not greater than 7' do
				instrument.price=789654321334
				expect(instrument.valid?).to eq(false)
			end

			it 'should be valid if price length not greater than 7' do
				instrument.price=78965
				expect(instrument.valid?).to eq(true)
			end

			it 'should be description length not greater than 1000' do
				instrument.description="good"*1000
				expect(instrument.valid?).to eq(false)
			end

				it 'should be  valid if description length not greater than 1000' do
				instrument.description="good"
				expect(instrument.valid?).to eq(true)
			end



		end
	end

	describe "Callback" do
		let(:user){create(:user)}
		let(:cart){create(:cart, user: user)}
		let(:instrument){create(:instrument, user: user)}

		context "line_items_present" do
			it "checks_for_line_items" do
				expect(cart.line_items.empty?).to eq(true)
            end
        end

        context "captilize" do
        	it "should_captilize_the_title" do
        		instrument.title="prs"
                instrument.validate!
        		expect(instrument.reload.title).to eq "PRS"
        	end
        end

	end

	describe "Associations" do
		let(:user){create(:user)}
		let(:instrument){create(:instrument,user: user)}
		it 'belongs to a user' do
			expect(instrument.user).to eq(user)
		end
	end
end