require 'vandelay/services/patients'
require 'vandelay/services/patient_records'

module Vandelay
  module REST
    module PatientsPatient
      def self.patients_srvc
        @patients_srvc ||= Vandelay::Services::Patients.new
      end

      def self.registered(app)
        app.get '/patients/:id' do
          id = Integer(params[:id]) rescue nil
          halt(400, {message: 'Invalid id'}.to_json) unless id

          result = Vandelay::REST::PatientsPatient.patients_srvc.retrieve_one(id)
          halt(404, {message: 'Patient not found'}.to_json) unless result
          
          json(result.to_h)
        end
      end
    end
  end
end
