module Ventrata
  class Availability < Base
    class << self
      def calendar(payload = {})
        post '/availability/calendar', payload.slice(:productId, :optionId, :localDateStart, :localDateEnd, :units, :currency), payload[:capabilities]
      end

      def check(payload = {})
        post '/availability', payload.slice(:productId, :optionId, :localDateStart, :localDateEnd, :units, :currency, :pickupRequested, :pickupPointId, :offerCode), payload[:capabilities]
      end

      def resources(payload = {})
        post '/availability/resources', payload.slice(:productId, :optionId, :availabilityId, :units), payload[:capabilities]
      end
    end
  end
end
