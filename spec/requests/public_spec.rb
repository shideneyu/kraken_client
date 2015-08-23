require_relative File.join '..', '..', 'lib', 'kraken_client'
require 'spectus'

# Testing Public Endpoints
kraken = KrakenClient.load
client = kraken.public

# Testing time
kraken_time = DateTime.parse(client.server_time.rfc1123)
utc_time = Time.now.getutc
Spectus.this { kraken_time.day }.MUST Equal: utc_time.day
Spectus.this { kraken_time.hour }.MUST Equal: utc_time.hour

# Assets
Spectus.this { client.assets.XETH.aclass }.MUST Eql: 'currency'

# Assets Pairs
Spectus.this { client.asset_pairs.XETHXXBT.altname }.MUST Eql: 'ETHXBT'

# Ticker
result = client.ticker(pair: 'XXBTZEUR, XXBTZGBP')
Spectus.this { result.XXBTZGBP.a.class }.MUST Equal: Array

# Order Book
order_book = client.order_book(pair: 'XXBTZEUR')
Spectus.this { order_book.XXBTZEUR.asks.class }.MUST Equal: Array

# Trades
trades = client.trades(pair: 'XXBTZEUR')
Spectus.this { trades.XXBTZEUR.class }.MUST Equal: Array

# Spread
spread = client.spread(pair: 'XXBTZEUR')
Spectus.this { spread.XXBTZEUR.class }.MUST Equal: Array
