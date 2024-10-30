module Ventrata
  class Identity < Base
    class << self
      def create(payload = {})
        post '/identities', payload.slice(:key, :data), [:identities]
      end

      def update(id, payload = {})
        patch "/identities/#{id}", payload.slice(:key, :data), [:identities]
      end
    end
  end
end
