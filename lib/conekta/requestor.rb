require 'faraday'
require 'base64'
module Conekta
  class Requestor
    def initialize()
      @api_key = Conekta.api_key
    end
    def api_url(url='')
      api_base = Conekta.api_base
      api_base + url
    end
    def request(meth, url, params=nil)
      url = self.api_url(url)
      meth = meth.downcase
#      begin
        conn = Faraday.new() do |faraday|
          faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end
        response = conn.method(meth).call do |req|
          req.url url
          req.headers['HTTP_AUTHORIZATION'] = "Basic #{ Base64.encode64('1tv5yJp3xnVZ7eK67m4h' + ':')}"
          req.headers['Accept'] = "vnd.conekta-v0.3.0"
          if params
            req.headers['Content-Type'] = 'application/json'
            req.body = params.to_json
          end
        end
        case response.status
        when 503
        when 200
        else
        end
#      rescue
#      end
      return JSON.parse(response.body)
    end
    private
    def set_headers()
      return headers
    end
  end
end
