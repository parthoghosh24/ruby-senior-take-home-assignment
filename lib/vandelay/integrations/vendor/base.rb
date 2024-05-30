require 'net/http'

module Vandelay
    module Integrations
      module Vendor
        class Base
            def initialize
                @token_data = nil
                @patient_data = nil
            end

            def authenticate(endpoint)
                response = get(endpoint)
                @token_data = JSON(response)
            end

            def patient(endpoint, token)
                response = get(endpoint, token)
                @patient_data = JSON(response)
            end

            def patient_record
                raise StandardError.new("Implement in the child")
            end

            private

            def get(endpoint, token = nil)
                class_name = self.class.name.split("::").last.downcase
                uri = URI("http://#{ Vandelay.config.dig("integrations", "vendors", "#{class_name}", "api_base_url") }#{endpoint}")
                headers = {}
                if token
                    headers.merge!({'Authorization' => "Bearer #{token}"})
                end
                http = Net::HTTP.new(uri.host, uri.port)
                response = http.get(uri.path, headers)
                response.body
            end
        end
      end
    end
end