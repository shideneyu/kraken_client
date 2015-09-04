# KrakenClient

[![Gem Version](https://badge.fury.io/rb/kraken_client.svg)](http://badge.fury.io/rb/kraken_client)
[![Code Climate](https://codeclimate.com/github/shideneyu/kraken_client/badges/gpa.svg)](https://codeclimate.com/github/shideneyu/kraken_client)
[![Test Coverage](https://codeclimate.com/github/shideneyu/kraken_client/badges/coverage.svg)](https://codeclimate.com/github/shideneyu/kraken_client/coverage)
[![Build Status](https://travis-ci.org/shideneyu/kraken_client.svg?branch=master)](https://travis-ci.org/shideneyu/kraken_client)

![kraken_client_blob](http://image.noelshack.com/fichiers/2015/34/1440350422-kraken3.png)

__KrakenClient__ is a Ruby wrapper of the [Kraken API](https://support.kraken.com/hc/en-us/articles/206548367-What-is-the-API-call-rate-limit-). 
[Kraken](https://www.kraken.com/) is a market exchange site serving those trading with Crypto-Currencies, such as **Bitcoin**.

It is a robust gem, and tested using the Awesome [Spectus gem](https://github.com/fixrb/spectus).

## Summary

* [Installation](#installation)
* [Usage](#usage)
  * [Configuration](#configuration)
    * [Call Rate Limiter](#call-rate-limiter)
    * [Requests](#requests)
    * [Public Endpoints](#public-endpoints)
        * [Asset Info](#asset-info)
        * [Asset Pairs](#asset-pairs)
        * [Ticker Information](#ticker-information)
        * [Order Book](#order-book)
        * [Trades](#trades)
        * [Spread](#spread)
    * [Private Endpoints](#private-endpoints)
        * [Balance](#balance)
        * [Trade Balance](#trade-balance)
        * [Open Orders](#open-orders)
        * [Closed Orders](#closed-orders)
        * [Query Orders](#query-orders)
        * [Trades History](#trades-history)
        * [Query Trades](#query-trades)
        * [Open Positions](#open-positions)
        * [Ledgers Info](#ledgers-info)
        * [Query Ledgers](#query-ledgers)
        * [Trade Volume](#trade-volume)
        * [Add Order](#add-order)
        * [Cancel Order](#cancel-order)
* [Donations](#donations)
* [Credits](#credits)
* [Contributing](#contributing)
* [License](#license)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'kraken_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kraken_client

And require it in your application:

    irb(main):001:0> require 'kraken_client'
    => true


## Usage

### Configuration ###
You can pass multiple variables that will be used in the gem.

```ruby
KrakenClient.configure do |config|
      config.api_key     = ENV['KRAKEN_API_KEY']
      config.api_secret  = ENV['KRAKEN_API_SECRET']
      config.base_uri    = 'https://api.kraken.com'
      config.api_version = 0
      config.limiter     = true
      config.tier        = 2
end
```

By default, the default values are the ones described in the above example.

You can also pass any of those options inline when loading an instance of KrakenClient.

```ruby
KrakenClient.load({base_uri: 'https://api.kraken.com', tier: 3}).config.tier
```


**/!\\ Important Note /!\\** If you wish to use the Private Endpoints, you need to specify an API Key, or an exception will be raised. 

### Call Rate Limiter ###

Kraken has implemented a security which limit API users to make too much requests to the server. Each user has a counter (which is bigger depending on your tier). Each call increments your counter, and if your counter reaches its limit, you are blocked for 15 minutes.

To prevent this, `KrakenClient` has a safeguard, which queue the request which should in theory be blocked and is executed two second later.

If you want to disable this option, pass the `limiter` variable in the configuration to false.

```ruby
KrakenClient.load({limiter: false}).config.tier
```

Also, this limiter is activated by default. You would like to specify your tier, and `KrakenClient` will automatically make the required adjustments. The default `tier` is 2.

```ruby
KrakenClient.load({tier: 3}).config.tier
```

For more information, please consult the [Kraken official documentation](https://support.kraken.com/hc/en-us/articles/206548367-What-is-the-API-call-rate-limit-).

### Requests ###

In all our examples henceforward, we consider this variable to be a loaded instance of `KrakenClient`

```ruby
client = KrakenClient.load
```

If you ever need to see the full documentation for the possible parameters, please take a look at the official [Kraken API docs](https://www.kraken.com/help/api).

A `KrakenClient::MissingParameter` exception will be raised along with the missing parameters if a required parameter is not passed.

### Public Endpoints ###


##### Server Time

This functionality is provided by Kraken to to aid in approximating the skew time between the server and client.

```ruby
time = client.public.server_time

time.unixtime #=> 1393056191
time.rfc1123 #=> "Sat, 22 Feb 2014 08:28:04 GMT"
```

##### Asset Info

Returns the assets that can be traded on the exchange. This method can be passed ```info```, ```aclass``` (asset class), and ```asset``` options. An example below is given for each:

```ruby
assets = client.public.assets
```

##### Asset Pairs

```ruby
pairs = client.public.asset_pairs
```

##### Ticker Information

```ruby
ticker_data = client.public.ticker('XLTCXXDG, ZUSDXXVN')
```

##### Order Book

Get market depth information for given asset pairs

```ruby
depth_data = client.public.order_book('LTCXRP')
```

##### Trades

Get recent trades

```ruby
trades = client.public.trades('LTCXRP')
```

##### Spread

Get spread data for a given asset pair

```ruby
spread = client.public.spread('LTCXRP')
```


#### Private Endpoints ####

##### Balance

Get account balance for each asset
Note: Rates used for the floating valuation is the midpoint of the best bid and ask prices

```ruby
balance = client.private.balance
```

##### Trade Balance

Get account trade balance

```ruby
trade_balance = client.private.trade_balance
```

##### Open Orders

```ruby
open_orders = client.private.open_orders
```

##### Closed Orders

```ruby
closed_orders = client.private.closed_orders
```

##### Query Orders

**Input:** Comma delimited list of transaction ids (txid)

See all orders

```ruby
orders = client.private.query_orders(txid: ids)
```

##### Trades History

Get array of all trades

```ruby
trades = client.private.trade_history
```

##### Query Trades

**Input:** Comma delimited list of transaction ids (txid)

See all orders

```ruby
orders = client.private.query_orders(txid: ids)
```

##### Open Positions

**Input:** Comma delimited list of transaction (txid) ids

```ruby
positions = client.private.open_positions(txid)
```

##### Ledgers Info

```ruby
ledgers = client.private.ledgers
```

##### Query Ledgers

**Input:** Comma delimited list of ledger ids

```ruby
ledgers = client.private.query_ledgers(id: ledger_ids)
```

##### Trade Volume

```ruby
ledgers = client.private.trade_volume
```

##### Add Order

There are 4 required parameters for buying an order. The example below illustrates the most basic order. Please see the [Kraken documentation](https://www.kraken.com/help/api#add-standard-order) for the parameters required for more advanced order types.

```ruby
# buying 0.01 XBT (bitcoin) for XRP (ripple) at market price
opts = {
  pair: 'XBTXRP',
  type: 'buy',
  ordertype: 'market',
  volume: 0.01
}

client.private.add_order(opts)
```

##### Cancel Order

```ruby
client.private.cancel_order("UKIYSP-9VN27-AJWWYC")
```

## Donations

If you like the work that has been done, do not hesitate in paying me a Coffee, I'd gladly accept it :)

![bitcoinadress](http://image.noelshack.com/fichiers/2015/35/1440407022-lastbtc.png)

Bitcoin Adress: 1LxffuH2C44mFNTYe1NtDz7FeWScCFZqM8
Donate here: https://www.coinbase.com/shideneyu

## Credits

This gem has been made by [Sidney SISSAOUI (shideneyu)](https://github.com/shideneyu). 

Special credits goes to [Alexander LEISHMAN](http://alexleishman.com/) and other [kraken_ruby](https://github.com/leishman/kraken_ruby/graphs/contributors)  contributors for their gem, which helped me to have a nice skeleton to begin **KrakenClient**. It would have been difficult for me to sign the requests if it wasn't thanks to their work.

If you want to be part of those credits, do not hesitate to contribute by doing some pull requests ;) !


## Contributing

1. Fork it ( https://github.com/[my-github-username]/swiffer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request


## License

See `LICENSE.md` file.
