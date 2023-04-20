require 'rails_helper'
RSpec.describe WishlistController do
	let(:seller){create(:seller)}
    let(:customer){create(:customer)}
      let(:seller_user){create(:user,accountable: seller,email: "kalai@gmail.com",password:"deva16")}
      let(:customer_user){create(:user,accountable: customer)}
      
      let(:instrument){create(:instrument,user: seller_user)}
      let(:wishlist){create(:wishlist,user: customer_user)}
    
	describe '#insert' do
       before{ sign_in(customer_user)}
       
        before do
       	wishlist.instruments<<instrument
       end
       context 'when user wishlist is present' do
       	 it 'should add instrument to wishlist' do
       	 	post :insert,params: {user_id: customer_user.id,instrument_id: instrument.id}
       	 	expect(wishlist.reload.instruments).to include((instrument))

       	end

       end

       it "redirects to the wishlist page" do
       	post :insert,params: {user_id: customer_user.id,instrument_id: instrument.id}
       	expect(response).to redirect_to(wishlist_path(wishlist))
       end
   end

   describe '#show' do
      
        before do
       	wishlist.instruments<<instrument
       end
        before{ sign_in(customer_user)}
       it 'should contain the instruments' do
       	expect(wishlist.reload.instruments).to include((instrument))

       end
       it 'should display the show page' do
       	expect(response).to have_http_status(200)
       end

   end

   describe '#destroy' do
   	  before do
       	wishlist.instruments<<instrument
       end
        before{ sign_in(customer_user)}
      it 'should remove instrument from wishlist' do
      	delete :destroy,params:{id: customer_user.id,wishlist_id: wishlist.id,instrument_id: instrument.id}
      	expect(wishlist.reload.instruments).to_not include(instrument)
      end

      it "redirects to the wishlist show page of the current user" do
      	delete :destroy,params:{id: customer_user.id,wishlist_id: wishlist.id,instrument_id: instrument.id}
      	expect(response).to redirect_to(wishlist_path(wishlist))
      end
      
   end
end


