class Payment < ApplicationRecord
	belongs_to :user
	belongs_to :order
	validates :card_number, :expiry_month,:expiry_year,:name_on_the_card,:cvv, presence: true
	validates :card_number, numericality: {only_integer: true}
	validates :card_number,length: {minimum: 12, maximum: 12}
	validates :expiry_month, numericality: {only_integer: true, greater_than:00, less_than:13}
	validates :expiry_month,length: {minimum: 2, maximum: 2}
	validates :expiry_year, numericality: {only_integer: true,greater_than: 2022}
	validates :expiry_year,length: {minimum: 4, maximum: 4}
	validates :cvv, numericality: {only_integer: true}
	validates :cvv,length: {minimum: 3, maximum: 3}


end
