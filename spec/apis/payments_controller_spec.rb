require 'rails_helper'

RSpec.describe "Payments" ,type: :request do
	describe 'GET/api/payments' do
	
     let(:token) {instance_double('Doorkeeper::AccessToken')}
     before do
     	allow_any_instance_of(Api::V1::PaymentsController).to receive(:doorkeeper_authorize!).and_return(true)
     end
	let(:seller) {create(:seller)}
	let(:user){create(:user,accountable: seller)}
	let!(:instrument){create(:instrument,user: user)}
	
		it  "assigns all payments as @payments" do
			get api_v1_payments_path
			expect(response).to have_http_status(200)
		end

	end
end