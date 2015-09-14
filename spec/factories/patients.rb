FactoryGirl.define do
	factory :patient do
		name "Patient Name"
		age "18"
		blood_group "O+"
		contact_details "Contact Details - Minimum 10 characters"
	end
end
