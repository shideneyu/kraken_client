module KrakenClient
  module Endpoints
    class Private < Base

      def perform(endpoint_name, args)
        url      = config.base_uri + url_path(endpoint_name)
        response = request_manager.call(url, endpoint_name, args)
      end

      def endpoint_names
        [
          :Balance, :TradeBalance, :OpenOrders ,:ClosedOrders, :QueryOrders,
          :TradesHistory, :QueryTrades, :OpenPositions, 
          :Ledgers, :QueryLedgers, :TradeVolume, :CancelOrder
        ]
      end

      def add_order(opts={})
        required_opts = %w{ pair type ordertype volume }
        leftover = required_opts - opts.keys.map(&:to_s)
        if leftover.length > 0
          raise ArgumentError.new("Required options, not given. Input must include #{leftover}")
        end
        perform('AddOrder', opts)
      end

      private

      def url_path(method)
        '/' + config.api_version.to_s + '/private/' + method
      end

    end
  end
end