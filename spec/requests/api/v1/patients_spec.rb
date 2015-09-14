require "rails_helper"

RSpec.describe "API creation" ,type: :request do

	let(:patient) {FactoryGirl.create(:patient)}

	context "GET /api/v1/patients" do
		it "should return all patients in json format" do
			8.times do
				FactoryGirl.create(:patient)
			end

			get "/api/v1/patients"
			expect(response.status).to eq(200)

	    response_body = JSON.parse(response.body)
			expect(response_body["data"].first.keys).to eq(["id","name","age","blood_group","contact_details"])
   	end
  end

  context "POST /api/v1/patients" do
		it "should save the patient information" do
			patient_params = {patient: {name: "New Patient", age: 62, blood_group: "O+", contact_details: "xyz"*10}}
			post "/api/v1/patients", patient_params
			
			expect(response.status).to eq(200)
	    response_body = JSON.parse(response.body)
	    expect(Patient.count).to eq(1)
			expect(response_body.keys).to eq(["data", "message"])

			data = response_body["data"]
			expect(data["name"]).to eq(patient_params[:patient][:name])
			expect(data["age"]).to eq(patient_params[:patient][:age])
			expect(data["blood_group"]).to eq(patient_params[:patient][:blood_group])
			expect(data["contact_details"]).to eq(patient_params[:patient][:contact_details])
			
			message = response_body["message"]
			expect(message).to eq("Patient record has been added successfully")
   	end
   	it "should show proper validation error messags" do
   		patient_params = {patient: {name: ""}}
			post "/api/v1/patients", patient_params

			expect(response.status).to eq(200)
	    response_body = JSON.parse(response.body)
			expect(response_body.keys).to eq(["data", "message", "error"])

			data = response_body["data"]
			expect(data["name"]).to eq(patient_params[:patient][:name])

			message = response_body["message"]
			expect(message).to eq("Invalid Patient Record Details")

			error = response_body["error"]
			expect(error).not_to be_blank
   	end
   	it "should show proper error message if the passed data is not valid" do
   		patient_params = {}
			post "/api/v1/patients", patient_params

			expect(response.status).to eq(200)
	    response_body = JSON.parse(response.body)
			expect(response_body.keys).to eq(["data", "message"])

			message = response_body["message"]
			expect(message).to eq("Invalid Input")
   	end
  end

  context "PUT /api/v1/patients/:id" do
		it "should update the patient information" do

			# This will create a patient using the patient factory defined by let 
			patient 

			updated_data = {patient: {name: "Updated Name", age: 62, blood_group: "B+", contact_details: "New Contact Details"}}
			
			put "/api/v1/patients/#{patient.id}", updated_data
			expect(response.status).to eq(200)
	    response_body = JSON.parse(response.body)
			expect(Patient.count).to eq(1)
			expect(response_body.keys).to eq(["data", "message"])

			data = response_body["data"]
			expect(data["name"]).to eq(updated_data[:patient][:name])
			expect(data["age"]).to eq(updated_data[:patient][:age])
			expect(data["blood_group"]).to eq(updated_data[:patient][:blood_group])
			expect(data["contact_details"]).to eq(updated_data[:patient][:contact_details])

			message = response_body["message"]
			expect(message).to eq("Patient record has been updated successfully")
   	end
   	it "should show proper error message if it fails to find the user with the id passed" do
   		put "/api/v1/patients/1234", {}
			expect(response.status).to eq(200)
	    response_body = JSON.parse(response.body)
			expect(response_body.keys).to eq(["message"])

			message = response_body["message"]
			expect(message).to eq("Patient record with id '1234' not found")
   	end
   	it "should show proper error message if the passed data is not valid" do
   		# This will create a patient using the patient factory defined by let 
			patient 

   		updated_data = {}
			put "/api/v1/patients/#{patient.id}", updated_data

			expect(response.status).to eq(200)
	    response_body = JSON.parse(response.body)
			expect(response_body.keys).to eq(["data", "message"])

			message = response_body["message"]
			expect(message).to eq("Invalid Input")
   	end
  end

  context "DELETE /api/v1/patients/:id" do
		it "should delete the patient record" do

			# This will create a patient using the patient factory defined by let 
			patient 

			delete "/api/v1/patients/#{patient.id}"
			expect(response.status).to eq(200)
	    response_body = JSON.parse(response.body)
			expect(Patient.count).to eq(0)
			expect(response_body.keys).to eq(["data", "message"])

			data = response_body["data"]
			expect(data["name"]).to eq(patient.name)
			expect(data["age"]).to eq(patient.age)
			expect(data["blood_group"]).to eq(patient.blood_group)
			expect(data["contact_details"]).to eq(patient.contact_details)

			message = response_body["message"]
			expect(message).to eq("Patient record has been removed successfully")
   	end
   	it "should show proper error message if it fails to find the user with the id passed" do
   		delete "/api/v1/patients/1234"
			expect(response.status).to eq(200)
	    response_body = JSON.parse(response.body)
			expect(response_body.keys).to eq(["message"])

			message = response_body["message"]
			expect(message).to eq("Patient record with id '1234' not found")
   	end
  end

end

