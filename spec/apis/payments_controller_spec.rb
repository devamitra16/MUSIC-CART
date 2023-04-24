require 'rails_helper'

RSpec.describe "Payments" ,type: :request do
	describe 'GET/api/payments' do
	
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
	
		it  "assigns all payments as @payments" do
			get api_v1_payments_path,params: {access_token: customer_token.token}
			expect(response).to have_http_status(200)
		end
		 it "should need access token" do
            	
                
            get api_v1_payments_path
			expect(response).to have_http_status(:unauthorized)
         end
         it  "should not allow seller to view customer payments" do
			get api_v1_payments_path,params: {access_token: seller_token.token}
			expect(response).to have_http_status(:forbidden)
		end

	end
end