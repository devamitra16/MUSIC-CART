FactoryBot.define do
	factory :order do
		address {"Coimbatore"}
		contact_number {"9876543243"}
		payment_method {"CashOnDelievery"}
		order_status {"ordered"}
		
	end
end