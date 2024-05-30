module Vandelay
    module Integrations
      module Vendor
        class Two < Vandelay::Integrations::Vendor::Base
            def authenticate
                super("/auth_tokens/1")
                puts @token_data
            end

            def patient(id)
                super("/records/#{id}" ,@token_data["auth_token"])
                @patient_data
            end

            def patient_record
                return {} if @patient_data.empty?

                {
                    "patient_id": @patient_data["id"],
                    "province": @patient_data["province_code"],
                    "allergies": @patient_data["allergies_list"],
                    "num_medical_visits": @patient_data["medical_visits_recently"] 
                }
            end
        end
       end
    end
end