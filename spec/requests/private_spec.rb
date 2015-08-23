require_relative File.join '..', '..', 'lib', 'kraken_client'
require 'spectus'

# Testing Public Endpoints
kraken = KrakenClient.load
client = kraken.private

binding.pry

# User Balance
Spectus.this { client.balance.class }.MUST Equal: Hash 

# Trade Balance
Spectus.this { client.trade_balance.c }.MUST Eq: '0.0000' 

# Open Orders
Spectus.this { client.open_orders.open.class }.MUST Equal: Hashie::Mash

# Closed Orders
Spectus.this { client.closed_orders.closed.class }.MUST Equal: Hashie::Mash

# Query Orders
Spectus.this do
  order = client.query_orders({txid: 'OKRRJ6-MH3UH-DV6IKT'})
  order['OKRRJ6-MH3UH-DV6IKT'].status
end.MUST Eq: 'canceled'

# Trades History
Spectus.this { client.trades_history.trades.class }.MUST Equal: Hashie::Mash

# Query Trades
Spectus.this do
  order = client.query_orders({txid: 'TGGPX6-6RB25-OBRPHS'})
  order['TGGPX6-6RB25-OBRPHS'].pair
end.MUST Eq: 'XETHZEUR'

# Open Positions

#CANT TEST

# Ledgers Info
Spectus.this { client.ledgers.ledger.class }.Must Equal: Hashie::Mash

# Query Ledgers
Spectus.this do
  ledger = client.query_ledgers(id: 'LRSNYS-DICDD-3QM34P')
  ledger['LRSNYS-DICDD-3QM34P'].class
 end.MUST Equal: Hashie::Mash

# Trade Volume
Spectus.this { client.trade_volume(id: 'XETHZEUR').count }.Must Eq: 2

# Add Order

# Cancel Order
