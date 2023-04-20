require 'rails_helper'

RSpec.describe Wishlist, type: :model do
  describe 'Associations' do

      let(:seller){create(:seller)}
      let(:customer){create(:customer)}
      let(:seller_user){create(:user,accountable: seller,email: "kalai689@gmail.com",password:"deva16")}
      let(:customer_user){create(:user,accountable: customer)}
      let(:wishlist){create(:wishlist,user: customer_user)}
      let(:instrument){create(:instrument,user: seller_user)}

      it 'belongs to a user' do
        expect(wishlist.user).to eq_to(customer_user)
      end
      it "has and belongs to many instruments" do
      
        association=Wishlist.reflect_on_association(:instruments).macro
        expect(association).to be(:has_and_belongs_to_many)
      end
    

    end
end
