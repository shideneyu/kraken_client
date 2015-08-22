require 'base64'
require 'securerandom'
require 'addressable/uri'
require 'httparty'
require 'hashie'
require 'pry'

module KrakenClient
  class Application

    def initialize(params)
      set_config(params)
    end

    def public(options = {})
      ::KrakenClient::Endpoints::Public.new(config, options)
    end

    def private(options = {})
      ::KrakenClient::Endpoints::Private.new(config, options)
    end

    def config
      ::KrakenClient.config.dup
    end

    private

    def set_config(params)
      params.each { |k, v| config.send("#{k}=", v) }
    end
  end
end
