require_relative File.join '..', '..', 'lib', 'kraken_client'
require 'spectus'
require 'vcr'
require 'webmock'

include WebMock::API

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb
end

# Testing Public Endpoints
kraken = KrakenClient.load
client = kraken.public

# Server Time
VCR.use_cassette("server_time") do
  kraken_time = DateTime.parse(client.server_time.rfc1123)
  utc_time = Time.now.getutc
  Spectus.this { kraken_time.day.class }.MUST Equal: Fixnum
  Spectus.this { kraken_time.hour.class }.MUST Equal: Fixnum
end

# Assets
VCR.use_cassette("assets") do
  Spectus.this { client.assets.XETH.aclass }.MUST Eql: 'currency'
end

# Assets Pairs
VCR.use_cassette("assets_pairs") do
  Spectus.this { client.asset_pairs.XETHXXBT.altname }.MUST Eql: 'ETHXBT'
end

# Ticker
VCR.use_cassette("ticker") do
  result = client.ticker(pair: 'XXBTZEUR, XXBTZGBP')
  Spectus.this { result.XXBTZGBP.a.class }.MUST Equal: Array
end

# Order Book
VCR.use_cassette("order_book") do
  order_book = client.order_book(pair: 'XXBTZEUR')
  Spectus.this { order_book.XXBTZEUR.asks.class }.MUST Equal: Array
end

# Trades
VCR.use_cassette("trades") do
  trades = client.trades(pair: 'XXBTZEUR')
  Spectus.this { trades.XXBTZEUR.class }.MUST Equal: Array
end

# Spread
VCR.use_cassette("spread") do
  spread = client.spread(pair: 'XXBTZEUR')
  Spectus.this { spread.XXBTZEUR.class }.MUST Equal: Array
end
