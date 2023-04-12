class Seller < ApplicationRecord
	has_one:user, as: :accountable
	
end
