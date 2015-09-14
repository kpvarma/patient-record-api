class Api::V1::PatientsController < ApplicationController
  def index
  	@patients = Patient.all
  	render json: { data: @patients }
  end

  def create
  	patient_params = permitted_params
  	unless patient_params.blank?
	  	@patient = Patient.new(patient_params)
	  	if @patient.save
	  		render json: { data: @patient, message: "Patient record has been added successfully" }
	  	else
	  		render json: { data: @patient, message: "Invalid Patient Record Details", error: @patient.errors }
	  	end
	  else
			render json: { data: @patient, message: "Invalid Input" }
	  end
  end

  def update
  	@patient = Patient.find_by_id(params[:id])
  	if @patient
  		patient_params = permitted_params
  		unless patient_params.blank?
  			@patient.assign_attributes(patient_params)
  			@patient.save
  			render json: { data: @patient, message: "Patient record has been updated successfully" }
  		else
  			render json: { data: @patient, message: "Invalid Input" }
  		end
  	else
  		render json: { message: "Patient record with id '#{params[:id]}' not found" }
  	end
  end

  def destroy
  	@patient = Patient.find_by_id(params[:id])
  	if @patient
  		@patient.destroy
	  	render json: { data: @patient, message: "Patient record has been removed successfully" }
  	else
  		render json: { message: "Patient record with id '#{params[:id]}' not found" }
  	end
  end

  private

  def permitted_params
  	begin
  		params[:patient].permit(:name, :age, :blood_group, :contact_details)
  	rescue
  		{}
  	end
  end

end