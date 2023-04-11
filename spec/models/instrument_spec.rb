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

			it 'is not valid for instrument without brand' do
				instrument.brand=nil
				expect(instrument.valid?).to eq(false)

			end

				it 'is not valid for instrument without price' do
				instrument.price=nil
				expect(instrument.valid?).to eq(false)

			end
				it 'is not valid for instrument without model' do
				instrument.model=nil
				expect(instrument.valid?).to eq(false)

			end

			it 'should be title length not greater than 30' do
				instrument.title="assbdnsjkddmdjjwmdnwkjdmxsksmxlsmmsajwksmmsmkwndmamws"
				expect(instrument.valid?).to eq(false)
			end

			it 'should be price length not greater than 7' do
				instrument.price="789654321334"
				expect(instrument.valid?).to eq(false)
			end

			it 'should be description length not greater than 1000' do
				instrument.description="good"*1000
				expect(instrument.valid?).to eq(false)
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