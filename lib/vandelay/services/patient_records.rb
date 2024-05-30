module Vandelay
  module Services
    class PatientRecords
      def retrieve_record_for_patient(patient)
        return nil if patient.records_vendor.nil? || patient.vendor_id.nil?

        cached = Vandelay::Util::Cache.instance.read("#{patient.records_vendor}_#{patient.vendor_id}")

        return JSON.parse cached if cached

        vendor_class = "Vandelay::Integrations::Vendor::#{patient.records_vendor.capitalize}".split('::').inject(Object) {|o,c| o.const_get c} 
        vendor = vendor_class.new
        vendor.authenticate
        vendor.patient patient.vendor_id
        patient_record = vendor.patient_record

        # Cache the data for 10 minutes
        Vandelay::Util::Cache.instance.write("#{patient.records_vendor}_#{patient.vendor_id}", JSON(patient_record), 10 * 60)
        patient_record
      end
    end
  end
end