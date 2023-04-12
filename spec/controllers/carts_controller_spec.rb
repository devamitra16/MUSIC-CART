require 'rails_helper'
RSpec.describe CartsController do
	describe '#show' do
		let(:customer) {create(:customer)}
	    let(:user){create(:user, accountable: customer)}
	    let(:instrument){create(:instrument,user: user)}
	    let(:cart){create(:cart,user: user)}
	    before do
	    	 cart.instruments<<instrument
        end
        it 'should show the instrument in the cart' do
        expect(cart.reload.instruments).to include(instrument)
        end
    end
    describe '#destroy' do
    	let(:customer) {create(:customer)}
	    let(:user){create(:user, accountable: customer)}
	    let(:instrument){create(:instrument,user: user)}
	    let(:cart){create(:cart,user: user)}
	    before{ sign_in(user)}
	    before do
	    	cart.instruments<<instrument
	    end
	    it 'should empty the cart' do
	    delete :destroy, params:{id: cart.id}
	    expect(cart.reload.instruments).to_not include(instrument)
        end

    end
end


