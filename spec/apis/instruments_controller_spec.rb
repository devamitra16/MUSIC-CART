require 'rails_helper'

RSpec.describe "Instruments" ,type: :request do
	describe 'GET/api/instruments' do
	
     let(:token) {instance_double('Doorkeeper::AccessToken')}
     before do
     	allow_any_instance_of(Api::V1::InstrumentsController).to receive(:doorkeeper_authorize!).and_return(true)
     end
	let(:seller) {create(:seller)}
	let(:user){create(:user,accountable: seller)}
	let!(:instrument){create(:instrument,user: user)}
	
		it  "assigns all instruments as @instruments" do
			get api_v1_instruments_path
			expect(JSON.parse(response.body)['Instruments']).to eq([instrument.as_json.stringify_keys])
		end

	end

	describe "POST #create" do
		let(:token) {instance_double('Doorkeeper::AccessToken')}
		before do
			allow_any_instance_of(Api::V1::InstrumentsController).to receive(:doorkeeper_authorize!).and_return(true)
       end
       context "when seller is signed in" do
        	let!(:seller) {create(:seller)}
	        let!(:user){create(:user,accountable: seller)}
            

            it "creates a new product and redirect to the instruments index" do
            	p attributes_for(:instrument)

            	post api_v1_instruments_path, params:{instrument: {title: "piano", brand: "PRS", model: "PRS",color: "red", condition: "good", description: "good product", price: 3456, quantity: 23 , user_id: user.id}}
            	# expect(JSON.parse(response.body)["instrument"]).to include(Instrument.last.as_json.stringify_keys)
            	expect(response).to have_http_status(200)
            end
        end
    end

    describe "GET #show" do
    	let(:token) {instance_double('Doorkeeper::AccessToken')}
		before do
			allow_any_instance_of(Api::V1::InstrumentsController).to receive(:doorkeeper_authorize!).and_return(true)
       end
		let(:seller) {create(:seller)}
	    let(:user){create(:user, accountable: seller)}
	    let(:instrument){create(:instrument,user: user)}
	    it "shows a particular instrument" do
            get api_v1_instrument_path(instrument), params:{id:instrument.id}
            expect(JSON.parse(response.body)["instrument"]).eql?(instrument)
        end
    end

    describe "PUT #update" do
    	let(:token) {instance_double('Doorkeeper::AccessToken')}
		before do
			allow_any_instance_of(Api::V1::InstrumentsController).to receive(:doorkeeper_authorize!).and_return(true)
       end
		let(:seller) {create(:seller)}
	    let(:user){create(:user, accountable: seller)}
	    let(:instrument){create(:instrument,user: user)}
	    it "updates a particular instrument" do
            put api_v1_instrument_path(instrument), params:{id:instrument.id,quantity: 39}
            expect(JSON.parse(response.body)["instrument"]).eql?(instrument)
        end
    end

    describe "DELETE #destroy" do
		let(:token) {instance_double('Doorkeeper::AccessToken')}
		before do
			allow_any_instance_of(Api::V1::InstrumentsController).to receive(:doorkeeper_authorize!).and_return(true)
       end
       context "when seller is signed in" do
        	let!(:seller) {create(:seller)}
	        let!(:user){create(:user,accountable: seller)}
            let(:instrument){create(:instrument,user: user)}

            it "deletes product and redirect to the instruments index" do
            	delete api_v1_instrument_path(instrument), params:{id:instrument.id}
            	
            	expect(response).to have_http_status(200)
            end
        end
    end



end