require_relative 'test_helper'

kraken = KrakenClient.load
client = kraken.public

# Server Time
VCR.use_cassette("server_time") do
  kraken_time = DateTime.parse(client.server_time.rfc1123)
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

# Ohlc
VCR.use_cassette("ohlc") do
  ohlc_data = client.ohlc(pair: 'XXBTZEUR', last: '1499436000', interval: '60')
  Spectus.this { ohlc_data.class }.MUST Equal: Hashie::Mash
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
