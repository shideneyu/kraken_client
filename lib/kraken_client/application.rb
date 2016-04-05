require 'active_support/inflector'
require 'base64'
require 'securerandom'
require 'addressabler'
require 'httparty'
require 'hashie'

module KrakenClient
  class Application

    def initialize(params)
      set_config(params)
    end

    def public(options = {})
      ::KrakenClient::Endpoints::Public.new(config, options)
    end

    def private(options = {})
      requires_api_keys

      ::KrakenClient::Endpoints::Private.new(config, options)
    end

    def config
      @config ||= ::KrakenClient.config.dup
    end

    private

    def requires_api_keys
      return unless api_keys_missing?

      fail KrakenClient::MissingApiKeys, 'This feature requires API credentials.'
    end

    def api_keys_missing?
      !(config.api_key && config.api_secret)
    end

    def set_config(params)
      params.each { |k, v| config.send("#{k}=", v) }
    end
  end
end
