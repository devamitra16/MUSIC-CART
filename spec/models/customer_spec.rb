require 'rails_helper'

RSpec.describe Cart, type: :model do
	describe 'Associations' do
		


  context "has one" do
    
        it 'should have has one user account' do
        association = Customer.reflect_on_association(:user).macro
        expect(association).to be(:has_one)
      
   end
  end
end

end