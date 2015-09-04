module KrakenClient
  module Endpoints
    class Private < Base

      def perform(endpoint_name, args)
        url      = config.base_uri + url_path(endpoint_name)
        response = Hashie::Mash.new(request_manager.call(url, endpoint_name, args))
      end

      def data
        {
          :Balance       => :balance,
          :TradeBalance  => :trade_balance,
          :OpenOrders    => :open_orders,
          :ClosedOrders  => :closed_orders,
          :QueryOrders   => [:query_orders,  params: [:txid]],
          :TradesHistory => :trades_history,
          :QueryTrades   => [:query_trades,  params: [:txid]],
          :OpenPositions => :open_positions, params: [:txid],
          :Ledgers       => :ledgers,
          :QueryLedgers  => [:query_ledgers, params: [:id]],
          :TradeVolume   => :trade_volume,
          :AddOrder      => [:add_order,     params: [:pair, :type, :ordertype, :volume]],
          :CancelOrder   => [:cancel_order,  params: [:txid]],
        }
      end

      def raise_exception(options, args)
        return unless options.is_a?(Hash)

        leftover = options[:params] - args.keys

        if leftover.length > 0
          fail ::KrakenClient::ArgumentError, "Required options absent. Input must include #{leftover}"
        end
      end

      private

      def url_path(method)
        '/' + config.api_version.to_s + '/private/' + method
      end
    end
  end
end
