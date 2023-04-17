require 'rails_helper'

RSpec.describe "Orders" ,type: :request do
	 describe "POST #create" do
    	let(:token) {instance_double('Doorkeeper::AccessToken')}
		before do
			allow_any_instance_of(Api::V1::OrdersController).to receive(:doorkeeper_authorize!).and_return(true)
       end
		    let(:customer) {create(:customer)}
			let(:user){create(:user, accountable: customer)}
			
			 it "creates a new order" do
			 	expect(Order.count).to eq 0
			 	# attr = attributes_for(:order)
			 	# attr[:payment_attributes] = attributes_for(:payment)
			 	#post :create, params:{order: {address: "cbe",contact_number: "9876543212",payment_attributes: [{card_number: "789698766789",expiry_month: 12,expiry_year: 2024,name_on_the_card: "devamitra",cvv:123}]}}
			 	post :create, params:{address: "cbe",contact_number: "9876543212",payment_attributes: [card_number: "789698766789",expiry_month: 12,expiry_year: 2024,name_on_the_card: "devamitra",cvv:123], format: :json}
			 	expect(Order.count).to eq 1
			 	expect(response).to have_http_status(200)
			 end
			#  it "redirects to the orders path" do
			#  	attr = attributes_for(:order)
			#  	attr[:payment_attributes] = attributes_for(:payment)
			#  	post :create, params:{order: attr}
            #     expect(response).to redirect_to(orders_path)
            # end
    end
    
     
end