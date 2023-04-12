class Payment < ApplicationRecord
	belongs_to :user
	belongs_to :order
	validates :card_number, :expiry_month,:expiry_year,:name_on_the_card,:cvv, presence: true
	
end
