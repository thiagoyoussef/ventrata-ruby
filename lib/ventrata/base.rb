module Ventrata
  class Base
    BASE_URL = 'https://api.ventrata.com/octo'
    CAPABILITIES = %i[pricing content pickups webhooks mappings offers questions extras adjustments cart cardPayments packages resources checkin gifts redemption identities]

    class << self
      def api_key
        Ventrata.api_key
      end

      def headers(capabilities)
        { Authorization: "Bearer #{api_key}", 'Content-Type' => 'application/json', "Octo-Capabilities": capabilities(capabilities) }
      end

      def capabilities(capabilities)
        return '' if capabilities.empty?

        capabilities.map { |capability| "octo/#{capability}" if CAPABILITIES.include?(capability.to_sym) }.join(', ')
      end

      def get(path, query = {}, capabilities)
        response = HTTParty.get("#{BASE_URL}#{path}", query: query, headers: headers(capabilities))

        parse(response)
      end

      def post(path, payload, capabilities)
        response = HTTParty.post("#{BASE_URL}#{path}", headers: headers(capabilities), body: payload.to_json)

        parse(response)
      end

      def patch(path, payload, capabilities)
        response = HTTParty.patch("#{BASE_URL}#{path}", headers: headers(capabilities), body: payload.to_json)

        parse(response)
      end

      def put(path, payload, capabilities)
        response = HTTParty.put("#{BASE_URL}#{path}", headers: headers(capabilities), body: payload.to_json)

        parse(response)
      end

      def delete(path, payload, capabilities)
        response = HTTParty.delete("#{BASE_URL}#{path}", headers: headers(capabilities), body: payload.to_json)

        parse(response)
      end

      def parse(response)
        body = JSON.parse(response.body)

        return body if response.code == 200

        { code: response.code, error: body['errorMessage'] }
      end
    end
  end
end
