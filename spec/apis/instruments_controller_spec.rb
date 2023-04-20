require 'rails_helper'

RSpec.describe "Instruments" ,type: :request do

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
	describe 'GET/api/instruments' do
	
     
	
	
	    it  "should need access token" do
			get'/api/v1/instruments'
			expect(response).to have_http_status(:unauthorized)
		end
	
		it  "should assign all instruments as @instruments" do
			get'/api/v1/instruments',params:{access_token: customer_token.token}
			expect(JSON.parse(response.body)['Instruments']).to eq([instrument.as_json.stringify_keys])
		end

		it  "should assign particular seller instruments as @instruments" do
			get'/api/v1/instruments',params:{access_token: seller_token.token}
			expect(JSON.parse(response.body)['Instruments']).to eq([instrument.as_json.stringify_keys])
		end

	end
	
    
	describe "POST #create" do
	
       context "when seller is signed in" do
        	 it "should need access token" do
            	
                
            	post '/api/v1/instruments', params:{instrument: {title: "piano", brand: "PRS", model: "PRS",color: "red", condition: "good", description: "good product", price: 3456, quantity: 23 }}
            	
            	expect(response).to have_http_status(:unauthorized)
             end
          
            

            it "creates a new product and redirect to the instruments index" do
            	
                
            	post '/api/v1/instruments', params:{access_token: seller_token.token,instrument: {title: "piano", brand: "PRS", model: "PRS",color: "red", condition: "good", description: "good product", price: 3456, quantity: 23 }}
            	
            	expect(response).to have_http_status(:created)
            end

           

            it "should not create instrument with invalid params" do
            	
                
            	post '/api/v1/instruments', params:{access_token: seller_token.token,instrument: {title: "piano", model: "PRS",color: "red", condition: "good", description: "good product", price: 3456, quantity: 23 }}
            	
            	expect(response).to have_http_status(:unprocessable_entity)
            end


        end

         it "should not allow customer to create an instrument" do
            	
                
            	post '/api/v1/instruments', params:{access_token: customer_token.token,instrument: {title: "piano", brand: "PRS", model: "PRS",color: "red", condition: "good", description: "good product", price: 3456, quantity: 23 }}
            	
            	expect(response).to have_http_status(:forbidden)
            end
    end

    describe "GET #show" do
    	 it  "should need access token" do
			get api_v1_instrument_path(instrument), params:{id:instrument.id}
			expect(response).to have_http_status(:unauthorized)
		end
		
	    it "shows a particular instrument" do
            get api_v1_instrument_path(instrument), params:{access_token: customer_token.token,id:instrument.id}
            expect(JSON.parse(response.body)["instrument"]).eql?(instrument)
        end
        
    end

    describe "PUT #update" do
    	it  "should need access token" do
			put api_v1_instrument_path(instrument), params:{id:instrument.id,quantity: 39}
			expect(response).to have_http_status(:unauthorized)
		end
	    it "updates a particular instrument" do
            put api_v1_instrument_path(instrument), params:{access_token: seller_token.token,id:instrument.id,quantity: 39}
            expect(JSON.parse(response.body)["instrument"]).eql?(instrument)
        end
          it "should not allow customer to update an instrument" do
            	
                
            	put api_v1_instrument_path(instrument), params:{access_token: customer_token.token,instrument: {title: "piano", brand: "PRS", model: "PRS",color: "red", condition: "good", description: "good product", price: 3456, quantity: 23 }}
            	
            	expect(response).to have_http_status(:forbidden)
            end
             it "should not allow other seller to update an instrument" do
            	
                
            	put api_v1_instrument_path(instrument), params:{access_token: seller_token1.token,instrument: {title: "piano", brand: "PRS", model: "PRS",color: "red", condition: "good", description: "good product", price: 3456, quantity: 23 }}
            	
            	expect(response).to have_http_status(:forbidden)
            end


    end

    describe "DELETE #destroy" do

		it  "should need access token" do
			delete api_v1_instrument_path(instrument), params:{id:instrument.id}
			expect(response).to have_http_status(:unauthorized)
		end
	    it "deletes a particular instrument" do
            delete api_v1_instrument_path(instrument), params:{access_token: seller_token.token,id:instrument.id}
            	
            expect(response).to have_http_status(204)
        end
          it "should not allow customer to delete an instrument" do
            	
                
            	delete api_v1_instrument_path(instrument), params:{access_token: customer_token.token,id:instrument.id}
            	expect(response).to have_http_status(:forbidden)
            end
             it "should not allow other seller to delete an instrument" do
            	
                
            	delete api_v1_instrument_path(instrument), params:{access_token: seller_token1.token,id:instrument.id}
            	expect(response).to have_http_status(:forbidden)
            end
      
         
    end



end