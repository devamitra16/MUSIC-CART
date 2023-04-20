require 'rails_helper'

RSpec.describe "Carts" ,type: :request do
	let(:customer){create(:customer)}
    let(:seller){create(:seller)}
    let(:seller1){create(:seller)}
    let(:customer_user){create(:user, accountable: customer)}
    let(:seller_user){create(:user, accountable: seller, email: "aishu@gmail.com", password: "deva16")}
    let(:seller_user1){create(:user, accountable: seller1, email: "hems@gmail.com", password: "deva16")}
    let(:customer_token){create(:doorkeeper_access_token,resource_owner_id: customer_user.id)}
    let(:seller_token){create(:doorkeeper_access_token,resource_owner_id: seller_user.id)}
    let(:seller_token1){create(:doorkeeper_access_token,resource_owner_id: seller_user1.id)}
    let!(:instrument){create(:instrument,user: seller_user)}
    let(:cart){create(:cart,user: customer_user)}

	 describe "GET #show" do
    	
        it  "should need access token" do
			get api_v1_cart_path(cart), params:{id:cart.id}
			expect(response).to have_http_status(:unauthorized)
		end
	    it "should show a particular cart" do
            get api_v1_cart_path(cart), params:{access_token: customer_token.token,id:cart.id}
           
            expect(response).to have_http_status(200)
        end
        it "should not allow sellers to view a particular cart" do
            get api_v1_cart_path(cart), params:{access_token: seller_token.token,id:cart.id}
           
            expect(response).to have_http_status(:forbidden)
        end


    end
    
     describe "DELETE #destroy" do
		
       context "when customer is signed in" do
        	
             before do
	    	    cart.instruments<<instrument
             end
              it  "should need access token" do
			delete api_v1_cart_path(cart), params:{id:cart.id}
            	
			expect(response).to have_http_status(:unauthorized)
		   end
            
            it "empties the cart" do
            	delete api_v1_cart_path(cart), params:{access_token: customer_token.token,id:cart.id}
            	
            	expect(response).to have_http_status(204)
            end
             it "should not allow sellers to delete a customer cart" do
            delete api_v1_cart_path(cart), params:{access_token: seller_token.token,id:cart.id}
            	
           
            expect(response).to have_http_status(:forbidden)
        end
        end
    end

    describe "POST #insert" do
    	 it  "should need access token" do
			post insert_api_v1_carts_path, params:{instrument_id:instrument.id}
            	
			expect(response).to have_http_status(:unauthorized)
		  end
		  it "should need instrument id params" do
		  	post insert_api_v1_carts_path, params:{access_token: customer_token.token}
            	
			expect(response).to have_http_status(:unprocessable_entity)
		  end
		   it "should not allow sellers to insert into a customer cart" do
            post insert_api_v1_carts_path, params:{access_token: seller_token.token,instrument_id:instrument.id}
            	
            	
           
            expect(response).to have_http_status(:forbidden)
        end

        # it "should allow customer to insert into cart" do
        #     post insert_api_v1_carts_path, params:{access_token: customer_token.token,instrument_id:instrument.id,quantity:1}
            	
            	
           
        #     expect(response).to have_http_status(200)
        # end




    end
end
