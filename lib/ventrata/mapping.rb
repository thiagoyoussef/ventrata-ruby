module Ventrata
  class Mapping < Base
    class << self
      def list
        get '/mappings', [:mappings]
      end

      def update(payload = {})
        put '/mappings', payload, [:mappings]
      end
    end
  end
end
