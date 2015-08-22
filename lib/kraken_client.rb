require 'kraken_client/version'
require 'kraken_client/application'
require 'kraken_client/configurable'
require 'kraken_client/endpoints/base'
require 'kraken_client/endpoints/public'
require 'kraken_client/endpoints/private'
require 'kraken_client/requests/base'
require 'kraken_client/requests/get'
require 'kraken_client/requests/post'
require 'kraken_client/requests/limiter'
require 'kraken_client/requests/content/body'
require 'kraken_client/requests/content/header'
require 'active_support/inflector'

module KrakenClient
  extend KrakenClient::Configurable

  def self.load(params = {})
    KrakenClient::Application.new(params)
  end

end
