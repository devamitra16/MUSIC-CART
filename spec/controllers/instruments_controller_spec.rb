require 'rails_helper'

RSpec.describe InstrumentsController do
	context "GET #index" do
		let!(:user){create(:user)}
		let!(:instrument){create(:instrument,user: user)}
		it "assigns all instruments as @instruments" do
			get :index
			expect(assigns(:instruments)).to eq([instrument])
		end
	end
	context "GET #show" do
		let(:seller) {create(:seller)}
	    let(:user){create(:user, accountable: seller)}
	    let(:instrument){create(:instrument,user: user)}
	    it "shows a particular instrument" do
            get :show ,params: {id: instrument.id}
            expect(instrument.reload.title).to eq(instrument.title)
        end
    end




	describe "POST #create" do
		context "when user signed in" do
			let(:seller) {create(:seller)}
			let(:user){create(:user, accountable: seller)}
			before{ sign_in(user)}
			 it "creates a new instrument" do
			 	expect(Instrument.count).to eq 0
			 	post :create, params:{instrument: attributes_for(:instrument)}
			 	expect(Instrument.count).to eq 1
			 end
			 it "redirects to the instruments index" do
			 	post :create, params:{instrument: attributes_for(:instrument)}
                expect(response).to redirect_to(instruments_path)
            end
        end
    end

    context "PATCH #update" do
        let(:seller) {create(:seller)}
	    let(:user){create(:user, accountable: seller)}
	    let(:instrument){create(:instrument,user: user)}
	    before{ sign_in(user)}
	    it "updates the instrument params" do
    	 
    	 patch :update,params: {id: instrument.id, instrument: {title: "oppp"}}
    	
    	
    	expect(instrument.reload.title).to eq("oppp")
       end
    end

    context "DESTROY #destroy" do
    	let(:seller) {create(:seller)}
	    let(:user){create(:user, accountable: seller)}
        let(:instrument){create(:instrument,user: user)}
	    it "deletes the instrument" do
	    	
            delete :destroy, params:{id: instrument.id}
	    	
	    	expect(response). to be_redirect
	    end
	end




end