module Zadarma
  module Methods
    def balance
      request :get, "/info/balance/"
    end

    def price(number)
      request :get, "/info/price/", number: number
    end

    def callback(from, to, params = {})
      request :get, "/request/callback/", params.merge(from: from, to: to)
    end

    def sip
      request :get, "/sip/"
    end

    def set_sip_caller(id, number)
      request :put, "/sip/callerid/", id: id, number: number
    end

    def redirection(params = {})
      request :get, "/sip/redirection/", params
    end

    def set_redirect(id, params)
      request :put, "/sip/redirection/", params.merge(id: id)
    end


    def pbx_internal
      request :get, "/pbx/internal/"
    end

    def pbx_record(id, status, params = {})
      request :put, "/pbx/internal/recording/", params.merge(id: id, status: status)
    end

    def send_sms(number, message, params = {})
      request :post, "/sms/send/", params.merge(number: number, message: message)
    end


    def statistics(time_start, time_end, params = {})
      result = request :get, "/statistics/", params.merge(start: time_s(time_start), end: time_s(time_end))

      result[:start] = Time.parse(result[:start])
      result[:end] = Time.parse(result[:end])
      result[:stats].each { |item| item[:callstart] = Time.parse(item[:callstart]) }

      result
    end

    def pbx_statistics(time_start, time_end)
      request :get, "/statistics/pbx/", start: time_s(time_start), end: time_s(time_end)
    end


    protected

    def time_s(value)
      value.to_time.strftime "%Y-%m-%d %H:%M:%S" if value.present?
    end
  end
end