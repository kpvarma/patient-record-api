class Patient < ActiveRecord::Base

	# Constants
  EXCLUDED_JSON_ATTRIBUTES = [:created_at, :updated_at]
	BLOOD_GROUP_LIST = ["O+", "O-", "B+", "B-", "A+", "A-", "AB+", "AB-"]

	validates :name, :presence=> true, length: { in: 3..256 }
	validates :age, :presence=> true, numericality: { only_integer: true }
	validates :blood_group, :presence=> true, :inclusion => {:in => BLOOD_GROUP_LIST, :message => "'%{value}' is not a valid blood group" }
	validates :contact_details, :presence=> true, length: { in: 10..256 }

	# Exclude some attributes info from json output.
  def as_json(options={})
    options[:except] ||= EXCLUDED_JSON_ATTRIBUTES
    super(options)
  end

end
