module KrakenClient
  module Requests
    class Get < Base

      def call(url, params, *)
        super

        HTTParty.get(url, query: parsed_params(params))
      end

      private

      def parsed_params(params)
        params.is_a?(Hash) ? params : { pair: params }
      end

    end
  end
end
