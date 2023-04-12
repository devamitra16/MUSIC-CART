require 'rails_helper'
RSpec.describe OrdersController do
	describe "POST #create" do
		
			let(:customer) {create(:customer)}
			let(:user){create(:user, accountable: customer)}
			before{ sign_in(user)}
			 it "creates a new order" do
			 	expect(Order.count).to eq 0
			 	attr = attributes_for(:order)
			 	attr[:payment_attributes] = attributes_for(:payment)
			 	post :create, params:{order: attr}
			 	expect(Order.count).to eq 1
			 end
			 it "redirects to the orders path" do
			 	attr = attributes_for(:order)
			 	attr[:payment_attributes] = attributes_for(:payment)
			 	post :create, params:{order: attr}
                expect(response).to redirect_to(orders_path)
            end
        
    end
    
end