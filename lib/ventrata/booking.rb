module Ventrata
  class Booking < Base
    class << self
      def list(params = {})
        get '/bookings', params.slice(:resellerReference, :supplierReference, :localDate, :localDateStart, :localDateEnd, :productId, :optionId), params[:capabilities]
      end

      def retrieve(uuid, capabilities: [])
        get "/bookings/#{uuid}", capabilities
      end

      def create(payload = {})
        post '/bookings', payload.slice(:uuid, :expirationMinutes, :productId, :optionId, :availabilityId, :unitItems, :currency, :pickupRequested, :pickupPointId, :pickupHotel, :pickupHotelRoom, :adjustments, :orderId, :identityId, :identityKey), payload[:capabilities]
      end

      def update(uuid, payload = {})
        patch "/bookings/#{uuid}", payload.slice(:uuid, :expirationMinutes, :productId, :optionId, :availabilityId, :unitItems, :offerCode), payload[:capabilities]
      end

      def confirm(uuid, payload = {})
        post "/bookings/#{uuid}/confirm", payload.slice(:emailReceipt, :resellerReference, :contact), payload[:capabilities]
      end

      def cancel(uuid, payload = {})
        delete "/bookings/#{uuid}", payload.slice(:reason), payload[:capabilities]
      end

      def extend(uuid, payload = {})
        post "/bookings/#{uuid}/extend", payload.slice(:expirationMinutes), payload[:capabilities]
      end
    end
  end
end
