module KrakenClient
  module Endpoints
    class Public < Base

      def perform(endpoint_name, args)
        response = request_manager.call(url(endpoint_name), args)
        return response.parsed_response if response.code == 200
        raise KrakenClient::Exception, "Response status #{response.status} received."
      end

      def data
        {
          :Time       => :server_time,
          :AssetPairs => :asset_pairs,
          :Depth      => :order_book,
          :Ticker     => :ticker,
          :OHLC       => [:ohlc,  params: [:pair, :last, :interval]],
          :Trades     => :trades,
          :Spread     => :spread,
          :Assets     => :assets,
        }
      end

      private

      def url(endpoint_name)
        @url = config.base_uri + '/' + config.api_version.to_s + '/public/' + endpoint_name
      end

      def raise_exception(*)
      end
    end
  end
end
