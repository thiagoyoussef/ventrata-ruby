module Ventrata
  class Availability < Base
    class << self
      def calendar(payload = {})
        post '/availability/calendar', payload.slice(:productId, :optionId, :localDateStart, :localDateEnd, :units)
      end

      def check(payload = {})
        post '/availability', payload.slice(:productId, :optionId, :localDateStart, :localDateEnd, :units)
      end
    end
  end
end
