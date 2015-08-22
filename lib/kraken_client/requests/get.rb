module KrakenClient
  module Requests
    class Get < Base

      def call(url, params, *)
        super

        HTTParty.get(url, query: params)
      end

    end
  end
end
