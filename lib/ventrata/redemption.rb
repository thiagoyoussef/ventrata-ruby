module Ventrata
  class Redemption < Base
    class << self
      def lookup(params = {})
        get '/redemption/lookup', params.slice(:reference), [:redemption]
      end

      def redeem(payload = {})
        post '/redemption/redeem', payload.slice(:redemptionCode), [:redemption]
      end

      def credentials(payload = {})
        post '/redemption/credentials', payload.slice(:reference, :apiKeys), [:redemption]
      end

      def validate(payload = {})
        post '/redemption/validate', payload.slice(:redemptionCode), [:redemption]
      end
    end
  end
end
