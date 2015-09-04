module KrakenClient
  module Requests
    class Limiter

      attr_reader :config, :previous_timestamps, :endpoint_name, :current_count

      def initialize(config)
        @config              = config
        @previous_timestamps = Time.now
        @current_count       = counter_total
      end

      def update(endpoint_name)
        return unless config.limiter
        @endpoint_name = endpoint_name

        decrement_current_count
      end

      private

      # Adds the number of seconds depending of the current tier value
      def refresh_current_count
        @current_count += ((Time.now - previous_timestamps) / seconds_to_decrement).to_int
        @current_count = counter_total if current_count > counter_total

        current_count
      end

      def decrement_current_count
        @current_count -= value_to_decrement

        if current_count < 0
          sleep value_to_decrement

          @current_count = value_to_decrement

          update(endpoint_name)
        else
          refresh_current_count

          @previous_timestamps = Time.now
        end
      end

      def value_to_decrement

        case endpoint_name
          when 'Ledger'        then 2
          when 'TradeHistory'  then 2
          when 'AddOrder'      then 0
          when 'CancelOrder'   then 0
          else                      1
        end          
      end

      def counter_total
        @counter ||= case config.tier
          when 0 then 10
          when 1 then 10
          when 2 then 10
          when 3 then 20
          when 4 then 20
        end
      end

      def seconds_to_decrement
        @decrement ||= case config.tier
          when 0 then 5
          when 1 then 5
          when 2 then 5
          when 3 then 2
          when 4 then 1
        end
      end
    end
  end
end