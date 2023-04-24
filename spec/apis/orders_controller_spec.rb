require 'rails_helper'

RSpec.describe "Orders" ,type: :request do
	 describe "POST #create" do
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

    before do
    	cart.instruments<<instrument
    end
            
    	
			
			 it "should create a new order" do
			 	
			 	post api_v1_orders_path, params:{access_token: customer_token.token,order: {address:"coimbatore",contact_number:"9876543212",payment_method:"CashOnDelievery"}}
			 	
			 	expect(response).to have_http_status(201)
			 end

			  it "should not create a new order with invalid params" do
			 	
			 	post api_v1_orders_path, params:{access_token: customer_token.token,order: {address:"coimbatore",payment_method:"CashOnDelievery"}}
			 	
			 	expect(response).to have_http_status(:unprocessable_entity)
			 end


			
    end

    	 describe "GET #show" do
    let(:customer){create(:customer)}
    let(:seller){create(:seller)}
    let(:customer1){create(:seller)}
    let(:customer_user){create(:user, accountable: customer)}
    let(:seller_user){create(:user, accountable: seller, email: "aishu@gmail.com", password: "deva16")}
    let(:customer_user1){create(:user, accountable: customer1, email: "hems@gmail.com", password: "deva16")}
    let(:customer_token){create(:doorkeeper_access_token,resource_owner_id: customer_user.id)}
    let(:seller_token){create(:doorkeeper_access_token,resource_owner_id: seller_user.id)}
    let(:customer_token1){create(:doorkeeper_access_token,resource_owner_id: customer_user1.id)}
    let!(:instrument){create(:instrument,user: seller_user)}
    let(:cart){create(:cart,user: customer_user)}
    let(:order){create(:order,cart: cart,user: customer_user)}
    	
    	
        

	    it "should show a particular order" do
            get api_v1_order_path(order), params:{access_token: customer_token.token,id:order.id}
           
            expect(response).to have_http_status(200)
        end
        it "should not allow sellers to view a particular order" do
            get api_v1_order_path(order), params:{access_token: seller_token.token,id:order.id}
           
            expect(response).to have_http_status(:forbidden)
        end
         it "should not allow other customers to view a particular order" do
            get api_v1_order_path(order), params:{access_token: customer_token1.token,id:order.id}
           
            expect(response).to have_http_status(:forbidden)
        end


    end

    describe "GET #index" do
    let(:customer){create(:customer)}
    let(:seller){create(:seller)}
    let(:customer1){create(:seller)}
    let(:customer_user){create(:user, accountable: customer)}
    let(:seller_user){create(:user, accountable: seller, email: "aishu@gmail.com", password: "deva16")}
    let(:customer_user1){create(:user, accountable: customer1, email: "hems@gmail.com", password: "deva16")}
    let(:customer_token){create(:doorkeeper_access_token,resource_owner_id: customer_user.id)}
    let(:seller_token){create(:doorkeeper_access_token,resource_owner_id: seller_user.id)}
    let(:customer_token1){create(:doorkeeper_access_token,resource_owner_id: customer_user1.id)}
    let!(:instrument){create(:instrument,user: seller_user)}
    let(:cart){create(:cart,user: customer_user)}
    let(:order){create(:order,cart: cart,user: customer_user)}
    	
        

	    it "should show all the orders" do
            get api_v1_orders_path, params:{access_token: customer_token.token}
           
            expect(response).to have_http_status(200)
        end
        it "should not allow sellers to view all the orders" do
            get api_v1_orders_path, params:{access_token: seller_token.token}
           
            expect(response).to have_http_status(:forbidden)
        end
        it "should not allow other customers to view all the orders" do
            get api_v1_orders_path, params:{access_token: customer_token1.token}
           
            expect(response).to have_http_status(:forbidden)
        end


    end



    
     
end




