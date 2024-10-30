module Ventrata
  class Gift < Base
    class << self
      def list(params = {})
        get '/gifts', params.slice(:resellerReference, :supplierReference), [:gifts]
      end

      def retrieve(uuid)
        get "/gifts/#{uuid}", [:gifts]
      end

      def create(payload = {})
        post '/gifts', payload.slice(:uuid, :expirationMinutes, :amount, :currency, :message, :recipient, :identityId, :identityKey), payload[:capabilities] << :gifts
      end

      def update(uuid, payload = {})
        patch "/gifts/#{uuid}", payload.slice(:uuid, :expirationMinutes, :amount, :currency, :message, :recipient), [:gifts]
      end

      def confirm(uuid, payload = {})
        post "/gifts/#{uuid}/confirm", payload.slice(:resellerReference, :contact), [:gifts]
      end

      def cancel(uuid, payload = {})
        delete "/gifts/#{uuid}", payload.slice(:reason), [:gifts]
      end

      def extend(uuid, payload = {})
        post "/gifts/#{uuid}/extend", payload.slice(:expirationMinutes), [:gifts]
      end
    end
  end
end
