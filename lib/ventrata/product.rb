module Ventrata
  class Product < Base
    class << self
      def list(params = {})
        get '/products', params.slice(:categoryId, :destinationId), params[:capabilities]
      end

      def retrieve(id, params = {})
        get "/products/#{id}", params.slice(:pickupRequested), params[:capabilities]
      end
    end
  end
end
