require 'kraken_client/configuration'

module KrakenClient
  module Configurable

    def config
      @config ||= ::KrakenClient::Configuration.new
    end

    def configure
      yield config if block_given?
    end

  end
end