module KrakenClient
  module Requests
    class Base

      attr_reader :config, :method, :type, :endpoint_name, :url

      def initialize(config, type)
        @config = config
        @type = type
      end

      def self.build(config, type)
        type = self.type(type)

        "KrakenClient::Requests::#{type}".constantize.new(config, type)
      end

      private

      def self.type(given_type)
        given_type == 'Public' ? 'Get' : 'Post'
      end
    end
  end
end
