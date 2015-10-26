require "digest/md5"
require "openssl"
require "base64"
require "faraday"

module Zadarma
  class Client
    class << self
      include Methods

      def request(method, path, params = {})
        raise "No auth data provided" unless Zadarma.api_key && Zadarma.api_secret

        params.merge!(format: "json")

        response = client.send(method, "/v1" + path, params) do |request|
          request.headers["Accept"] = "application/json"
          request.headers["Authorization"] = "#{Zadarma.api_key}:#{signature("/v1" + path, params)}"
        end
        
        result = ActiveSupport::JSON.decode(response.body).with_indifferent_access
        raise Zadarma::Error.new("Error [HTTP #{response.status}]: #{result[:message]} ") unless "success" == result[:status]

        result.except("status")
      
      rescue ActiveSupport::JSON.parse_error
        raise Zadarma::Error.new("Response is not JSON: #{response.body}")

      end


      protected

      def client
        @client ||= ::Faraday.new(url: "https://api.zadarma.com") do |faraday|
          faraday.request :url_encoded
          faraday.response :logger if Zadarma.log_requests
          faraday.adapter Faraday.default_adapter
        end
      end

      def signature(url, params)
        query = Hash[params.sort].to_query
        sign_str = url + query + Digest::MD5.hexdigest(query)
        sign = Base64.encode64(OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha1"), Zadarma.api_secret, sign_str)).strip
        sign
      end
    end
  end
end