
# **KrakenClient**

`KrakenClient` is a **Ruby** wrapper of the Kraken API. Kraken is a market exchange site serving those trading with Crypto-Currencies, such as **Bitcoin**.

This gem tends to be a replacement for [kraken_ruby](https://github.com/leishman/kraken_ruby), another wrapper, from which it is originally forked from.

It has every features of the latter gem, with improved readability, usability, maintenability, and fully speced.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kraken_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kraken_ruby

And require it in your application:

    irb(main):001:0> require 'kraken_client'
    => true


## Usage

### Configuration ###
You can pass multiple variables that will be used in the gem.

```ruby
KrakenClient.configure do
      @api_key     = ENV['KRAKEN_API_KEY']
      @api_secret  = ENV['KRAKEN_API_SECRET']
      @base_uri    = 'https://api.kraken.com'
      @api_version = 0
end
```

By default, the default values are the ones described in the above example.

**/!\\ Important Note /!\\** If you wish to use the Private Endpoints, you need to specify an API Key, or an exception will be raised. 

### Examples ###

In all our examples henceforward, we consider this variable to be a loaded instance of `KrakenClient`

    client = KrakenClient.load


#### *Public Endpoints* ####


#### Server Time

This functionality is provided by Kraken to to aid in approximating the skew time between the server and client.

```ruby
time = client.public.server_time

time.unixtime #=> 1393056191
time.rfc1123 #=> "Sat, 22 Feb 2014 08:28:04 GMT"
```

#### Asset Info

Returns the assets that can be traded on the exchange. This method can be passed ```info```, ```aclass``` (asset class), and ```asset``` options. An example below is given for each:

```ruby
assets = client.public.assets
```

#### Asset Pairs

```ruby
pairs = client.public.asset_pairs
```

#### Ticker Information

```ruby
ticker_data = client.public.ticker('XLTCXXDG, ZUSDXXVN')
```

#### Order Book

Get market depth information for given asset pairs

```ruby
depth_data = client.public.order_book('LTCXRP')
```

#### Trades

Get recent trades

```ruby
trades = client.public.trades('LTCXRP')
```

#### Spread

Get spread data for a given asset pair

```ruby
spread = client.pbulic.spread('LTCXRP')
```


#### *Private Endpoints* ####

#### Balance

Get account balance for each asset
Note: Rates used for the floating valuation is the midpoint of the best bid and ask prices

```ruby
balance = kraken.balance
```

#### Trade Balance

Get account trade balance

```ruby
trade_balance = kraken.trade_balance
```

#### Open Orders

```ruby
open_orders = kraken.open_orders
```

#### Closed Orders

```ruby
closed_orders = kraken.closed_orders
```

#### Query Orders

See all orders

```ruby
orders = kraken.query_orders
```

#### Trades History

Get array of all trades

```ruby
trades = kraken.trade_history
```

#### Query Trades

**Input:** Comma delimited list of transaction (tx) ids

```ruby
trades = kraken.query_trades(tx_ids)
```

#### Open Positions

**Input:** Comma delimited list of transaction (tx) ids

```ruby
positions = kraken.open_positions(tx_ids)
```

#### Ledgers Info

```ruby
ledgers = kraken.ledgers_info
```

#### Ledgers Info

**Input:** Comma delimited list of ledger ids

```ruby
ledgers = kraken.query_ledgers(ledger_ids)
```

#### Trade Volume

**Input:** Comma delimited list of asset pairs

```ruby
asset_pairs = 'XLTCXXDG, ZEURXXDG'
volume = kraken.query_ledgers(asset_pairs)
```

#### Add Order

There are 4 required parameters for buying an order. The example below illustrates the most basic order. Please see the [Kraken documentation](https://www.kraken.com/help/api#add-standard-order) for the parameters required for more advanced order types.
```ruby
# buying 0.01 XBT (bitcoin) for XRP (ripple) at market price
opts = {
  pair: 'XBTXRP',
  type: 'buy',
  ordertype: 'market',
  volume: 0.01
}

kraken.add_order(opts)

```

#### Cancel Order

```ruby
kraken.cancel_order("UKIYSP-9VN27-AJWWYC")
```


## Credits

This gem has been built by [Sidney SISSAOUI (shideneyu)](https://github.com/shideneyu). 

Special credits goes to [Alexander LEISHMAN](http://alexleishman.com/) and other  [kraken_ruby](https://github.com/leishman/kraken_ruby) contributors for having established the base of **KrakenClient**. It would have been difficult for me to sign the requests if it wasn't thanks to their work.
If you want to be part of those credits, do not hesitate to contribute by doing some pull requests ;) !


## Contributing

1. Fork it ( https://github.com/[my-github-username]/swiffer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


## License

See `LICENSE.md` file.
