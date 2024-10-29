module Ventrata
  class Product < Base
    class << self
      def list(params = {})
        get '/products', query: params.slice(:categoryId, :destinationId)
      end

      def retrieve(id)
        get "/products/#{id}"
      end
    end
  end
end
