module Ventrata
  class Booking < Base
    class << self
      def list(params = {})
        get '/bookings', query: params.slice(:resellerReference, :supplierReference, :localDate, :localDateStart, :localDateEnd, :productId, :optionId)
      end

      def retrieve(uuid)
        get "/bookings/#{uuid}"
      end

      def create(payload = {})
        post '/bookings', payload.slice(:uuid, :expirationMinutes, :productId, :optionId, :availabilityId, :unitItems)
      end

      def update(uuid, payload = {})
        patch "/bookings/#{uuid}", payload.slice(:uuid, :expirationMinutes, :productId, :optionId, :availabilityId, :unitItems)
      end

      def confirm(uuid, payload = {})
        post "/bookings/#{uuid}/confirm", payload.slice(:emailReceipt, :resellerReference, :contact)
      end

      def destroy(uuid)
        delete "/bookings/#{uuid}"
      end

      def extend(uuid, payload = {})
        post "/bookings/#{uuid}/extend", payload.slice(:expirationMinutes)
      end
    end
  end
end
