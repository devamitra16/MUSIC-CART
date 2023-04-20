require 'rails_helper'
RSpec.describe OrdersController do
	let(:seller){create(:seller)}
    let(:customer){create(:customer)}
      let(:seller_user){create(:user,accountable: seller,email: "kalaiv@gmail.com",password:"deva16")}
      let(:customer_user){create(:user,accountable: customer)}
      
      let(:instrument){create(:instrument,user: seller_user)}
       let(:cart){create(:cart,user: customer_user)}
        let(:order){build(:order,cart: cart,user: customer_user)}
	   

	describe "POST #create" do
		     before do
	    	 cart.instruments<<instrument
             end

			before{ sign_in(customer_user)}
			 it "creates a new order" do
			 	expect(Order.count).to eq 0
			 	attr = attributes_for(:order)
			 	attr[:payment_attributes] = attributes_for(:payment)
			 	post :create, params:{order: attr,cart_id:cart.id,user_id:customer_user.id}
			 	expect(Order.count).to eq 1
			 end
			 it "redirects to the order path" do
			 	
                expect(response).to have_http_status(200)
            end
        
    end

    describe "GET #index" do
        before do
    	 cart.instruments<<instrument
        end

	   before{ sign_in(customer_user)}


	   it "redirects to the order path" do
		expect(response).to have_http_status(200)
       end

   end

  

   


    
end