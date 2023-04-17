FactoryBot.define do
	factory :user do
	email {"sarveskarthik@gmail.com"}
	password {"deva16"}
	password_confirmation {"deva16"}
	name {"sarves"}
	
    for_customer
    
	trait :for_customer do
		association :accountable, factory: :customer
	end

	trait :for_seller do
		association :accountable, factory: :seller
	end




	end
	factory :customer do
	end

	factory :seller do
	end
end

