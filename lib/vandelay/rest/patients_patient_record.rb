require 'vandelay/services/patients'
require 'vandelay/services/patient_records'

module Vandelay
  module REST
    module PatientsPatientRecord
      def self.patients_srvc
        @patients_srvc ||= Vandelay::Services::Patients.new
      end

      def self.patient_record_srvc
        @patient_record_srvc ||= Vandelay::Services::PatientRecords.new
      end

      def self.registered(app)
        app.get '/patients/:patient_id/record' do
          patient_id = Integer(params[:patient_id]) rescue nil
          halt(400, {message: 'Invalid id'}.to_json) unless patient_id

          patient = Vandelay::REST::PatientsPatient.patients_srvc.retrieve_one patient_id

          halt(404, {message: 'Patient not found'}.to_json) unless patient

          result = Vandelay::REST::PatientsPatientRecord.patient_record_srvc.retrieve_record_for_patient patient

          halt(404, {message: 'Patient record not found'}.to_json) unless result

          json(result.to_h)
        end
      end
    end
  end
end
