require_relative 'test_helper'

kraken = KrakenClient.load
client = kraken.private

# User Balance
VCR.use_cassette("balance") do
  Spectus.this { client.balance.class }.MUST Equal: ActiveSupport::HashWithIndifferentAccess
end

# Trade Balance
VCR.use_cassette("trade_balance") do
  Spectus.this { client.trade_balance['c'] }.MUST Eql: '0.0000'
end

# Open Orders
VCR.use_cassette("open_orders") do
  Spectus.this { client.open_orders['open'].class }.MUST Equal: ActiveSupport::HashWithIndifferentAccess
end

# Closed Orders
VCR.use_cassette("closed_orders") do
  Spectus.this { client.closed_orders['closed'].class }.MUST Equal: ActiveSupport::HashWithIndifferentAccess
end

# Query Orders
VCR.use_cassette("query_orders") do
  Spectus.this do
    order = client.query_orders({txid: 'OKRRJ6-MH3UH-DV6IKT'})
    order['OKRRJ6-MH3UH-DV6IKT']['status']
  end.MUST Eql: 'canceled'
end

# Trades History
VCR.use_cassette("trades_history") do
  Spectus.this { client.trades_history['trades'].class }.MUST Equal: ActiveSupport::HashWithIndifferentAccess
end

# Query Trades
VCR.use_cassette("query_trades") do
  Spectus.this do
    order = client.query_trades({txid: 'THZPTW-BMF6X-VWMN5P'})
    order['THZPTW-BMF6X-VWMN5P']['pair']
  end.MUST Eql: 'XETHZEUR'
end

# Open Positions
#CANT TEST, PARAMS DO NOT WORK

# Ledgers Info
VCR.use_cassette("ledgers") do
  Spectus.this { client.ledgers['ledger'].class }.MUST Equal: ActiveSupport::HashWithIndifferentAccess
end

# Query Ledgers
VCR.use_cassette("query_ledgers") do
  Spectus.this do
    ledger = client.query_ledgers(id: 'LRSNYS-DICDD-3QM34P')
    ledger['LRSNYS-DICDD-3QM34P'].class
  end.MUST Equal: ActiveSupport::HashWithIndifferentAccess
end

# Trade Volume
VCR.use_cassette("trade_volume") do
  Spectus.this { client.trade_volume(pair: 'XETHZEUR').count }.MUST Equal: 4
end

# Add Order
VCR.use_cassette("add_order") do
  Spectus.this do

    opts = {
      pair: 'ETHEUR',
      type: 'buy',
      ordertype: 'market',
      volume: 0.01
    }

    client.add_order(opts)['txid']
  end.MUST Eql: ['OEDIZV-VDAW3-RHLJVB']
end

# Add Order: error - insufficient funds
VCR.use_cassette("add_order_error_insufficient_funds") do
  Spectus.this do

    opts = {
      pair: 'ETHEUR',
      type: 'buy',
      ordertype: 'market',
      volume: 0.01
    }

    client.add_order(opts)
  end.MUST RaiseException: KrakenClient::ErrorResponse
end

# Cancel Order
VCR.use_cassette("cancel_order") do
  Spectus.this do
    client.cancel_order(txid: 'ODEC3J-QAMVD-NSF7XD').count
  end.MUST Eql: 1
end
