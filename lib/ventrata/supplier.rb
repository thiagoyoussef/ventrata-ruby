module Ventrata
  class Supplier < Base
    class << self
      def list
        get '/suppliers'
      end

      def retrieve(id)
        get "/suppliers/#{id}"
      end
    end
  end
end
