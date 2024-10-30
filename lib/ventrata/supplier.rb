module Ventrata
  class Supplier < Base
    class << self
      def list(capabilities: [])
        get '/suppliers', {}, capabilities
      end

      def retrieve(id, capabilities: [])
        get "/suppliers/#{id}", {}, capabilities
      end
    end
  end
end
