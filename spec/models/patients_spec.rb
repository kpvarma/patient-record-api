require 'rails_helper'
RSpec.describe Patient, type: :model do
	
	let(:patient1) {FactoryGirl.create(:patient, name: "Ram")}
	let(:patient2) {FactoryGirl.create(:patient, name: "Lakshman")}
	let(:patient3) {FactoryGirl.create(:patient, name: "Sita")}

	context "Factory" do
		it "should validate all the patient factories" do
			patient = FactoryGirl.build(:patient)
			expect(patient.valid?).to be true
		end
	end

	context "Validations" do
    it { should validate_presence_of :name }
    it { should allow_value('Krishnaprasad Varma').for(:name )}
    it { should_not allow_value('KP').for(:name )}
    it { should_not allow_value("x"*257).for(:name )}

    it { should validate_presence_of :age }
    it { should allow_value('21').for(:age )}
    it { should_not allow_value('xyz').for(:age )}
    
    it { should validate_presence_of :blood_group }
    it { should validate_inclusion_of(:blood_group).in_array(Patient::BLOOD_GROUP_LIST)}
    
    it { should validate_presence_of :contact_details }
    it { should allow_value('Qwinix Technologies, Hebbal Industrial Estate, Mysore').for(:contact_details )}
    it { should_not allow_value('x*9').for(:contact_details )}
    it { should_not allow_value("x"*257).for(:contact_details )}
    
  end

end
