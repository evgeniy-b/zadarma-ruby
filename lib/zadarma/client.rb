require "digest/md5"
require "openssl"
require "base64"
require "faraday"

module Zadarma
  class Client
    include Methods

    def initialize(api_key, api_secret)
      @api_key = api_key
      @api_secret = api_secret
    end

    def request(method, path, params = {})
      raise "No auth data provided" unless @api_key && @api_secret

      params.merge!(format: "json")

      response = client.send(method, "/v1" + path, params) do |request|
        request.headers["Accept"] = "application/json"
        request.headers["Authorization"] = "#{@api_key}:#{signature("/v1" + path, params)}"
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
      sign = Base64.encode64(OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new("sha1"), @api_secret, sign_str)).strip
      sign
    end

    # Class methods
    class << self
      include Methods

      def request(method, path, params = {})
        # Make instance and execute request
        obj = Zadarma::Client.new(Zadarma.api_key, Zadarma.api_secret)
        obj.request(method, path, params = {})
      end
    end


  end
end