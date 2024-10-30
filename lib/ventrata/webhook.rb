module Ventrata
  class Webhook < Base
    class << self
      def list
        get '/webhooks', [:webhooks]
      end

      def create(payload = {})
        post '/webhooks', payload.slice(:url, :event), [:webhooks]
      end

      def destroy(id)
        delete "/webhooks/#{id}", [:webhooks]
      end
    end
  end
end
