require 'observer'

module KrakenClient
  module Requests
    class Base

      include Observable

      attr_reader :config, :type, :endpoint_name, :url

      def initialize(config, type)
        @config = config
        @type = type
        add_observer(config.limiter_interface)
      end

      def self.build(config, type)
        type = self.type(type)

        "KrakenClient::Requests::#{type}".constantize.new(config, type)
      end

      def call(url, _endpoint_name, _options = nil)
        changed
        notify_observers(url.split('/').last)
      end

      def self.type(given_type)
        given_type == 'Public' ? 'Get' : 'Post'
      end
    end
  end
end
