FactoryGirl.define do
	
	sequence(:username) {|n| "username#{n}" }

	factory :user do
		name "User Name"
		username
		password "Password@1"
	end
end
