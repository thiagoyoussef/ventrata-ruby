module Ventrata
  class Base
    BASE_URL = 'https://api.ventrata.com/octo'

    class << self
      def api_key
        Ventrata.api_key
      end

      def headers
        { Authorization: "Bearer #{api_key}", 'Content-Type' => 'application/json', "Octo-Capabilities": capabilities }
      end

      def capabilities
        ''
      end

      def get(path, options = {})
        response = HTTParty.get("#{BASE_URL}#{path}", options.merge(headers: headers))

        response_parse(response)
      end

      def post(path, payload)
        response = HTTParty.post("#{BASE_URL}#{path}", headers: headers, body: payload.to_json)

        response_parse(response)
      end

      def patch(path, payload)
        response = HTTParty.patch("#{BASE_URL}#{path}", headers: headers, body: payload.to_json)

        response_parse(response)
      end

      def delete(path)
        response = HTTParty.delete("#{BASE_URL}#{path}", headers: headers)

        response_parse(response)
      end

      def response_parse(response)
        body = JSON.parse(response.body)

        return body if response.code == 200

        { code: response.code, error: body['errorMessage'] }
      end
    end
  end
end
