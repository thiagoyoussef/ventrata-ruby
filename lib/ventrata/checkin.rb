module Ventrata
  class Checkin < Base
    class << self
      def lookup(payload = {})
        post '/checkin/lookup', payload.slice(:email, :mobile, :reference, :verification, :identityId, :identityKey), payload[:capabilities] << :checkin
      end
    end
  end
end
