require 'rails_helper'

RSpec.describe "Carts" ,type: :request do
	 describe "GET #show" do
    	let(:token) {instance_double('Doorkeeper::AccessToken')}
		before do
			allow_any_instance_of(Api::V1::CartsController).to receive(:doorkeeper_authorize!).and_return(true)
       end
		let(:seller) {create(:seller)}
	    let(:user){create(:user, accountable: seller)}
	    let(:instrument){create(:instrument,user: user)}
        let(:cart){create(:cart,user: user)}
	    it "shows a particular cart" do
            get api_v1_cart_path(cart), params:{id:cart.id}
           
            expect(response).to have_http_status(200)
        end

    end
     describe "DELETE #destroy" do
		let(:token) {instance_double('Doorkeeper::AccessToken')}
		before do
			allow_any_instance_of(Api::V1::CartsController).to receive(:doorkeeper_authorize!).and_return(true)
       end
       context "when customer is signed in" do
        	let!(:customer) {create(:customer)}
	        let!(:user){create(:user,accountable: customer)}
	        let(:instrument){create(:instrument,user: user)}
            let(:cart){create(:cart,user: user)}
             before do
	    	    cart.instruments<<instrument
             end
            
            it "empties the cart" do
            	delete api_v1_cart_path(cart), params:{id:cart.id}
            	
            	expect(response).to have_http_status(200)
            end
        end
    end
end
