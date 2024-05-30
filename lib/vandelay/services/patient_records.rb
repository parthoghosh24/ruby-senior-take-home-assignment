module Vandelay
  module Services
    class PatientRecords
      def retrieve_record_for_patient(patient)
        return nil if patient.records_vendor.nil? || patient.vendor_id.nil?

        vendor_class = "Vandelay::Integrations::Vendor::#{patient.records_vendor.capitalize}".split('::').inject(Object) {|o,c| o.const_get c} 
        vendor = vendor_class.new
        vendor.authenticate
        vendor.patient patient.vendor_id
        vendor.patient_record
      end
    end
  end
end