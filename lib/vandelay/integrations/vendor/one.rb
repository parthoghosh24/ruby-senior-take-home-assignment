module Vandelay
    module Integrations
      module Vendor
        class One < Vandelay::Integrations::Vendor::Base
            def authenticate
                super("/auth/1")
                puts @token_data
            end

            def patient(id)
                super("/patients/#{id}", @token_data["token"])
                @patient_data
            end

            def patient_record
                return {} if @patient_data.empty?

                {
                    "patient_id": @patient_data["id"],
                    "province": @patient_data["province"],
                    "allergies": @patient_data["allergies"],
                    "num_medical_visits": @patient_data["recent_medical_visits"] 
                }
            end
        end
       end
    end
end