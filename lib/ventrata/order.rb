module Ventrata
  class Order < Base
    class << self
      def retrieve(id, capabilities: [])
        get "/orders/#{id}", capabilities << :cart
      end

      def create(payload = {})
        post '/orders', payload.slice(:currency, :expirationMinutes, :identityId, :identityKey), payload[:capabilities] << :cart
      end

      def extend(id, payload = {})
        post "/orders/#{id}/extend", payload.slice(:expirationMinutes), [:cart]
      end

      def confirm(id, payload = {})
        post "/orders/#{id}/confirm", payload.slice(:contact), [:cart]
      end

      def cancel(id, payload = {})
        delete "/orders/#{id}", payload.slice(:reason), [:cart]
      end
    end
  end
end
