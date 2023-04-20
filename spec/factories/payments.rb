FactoryBot.define do
	factory :payment do
		card_number {"789698766789"}
		expiry_month {12}
		expiry_year {2028}
		name_on_the_card {"devamitra"}
		cvv {123}
	end
end