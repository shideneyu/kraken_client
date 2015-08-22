require 'spec_helper'

describe KrakenClient::Endpoints::Public do

  before :each do
    sleep 0.3 # to prevent rapidly pinging the Kraken server
  end

  let(:kraken) { KrakenClient.load }
  let(:client) { kraken.public }

  it "gets the proper server time" do
    kraken_time = DateTime.parse(client.server_time.rfc1123)
    utc_time = Time.now.getutc
    expect(kraken_time.day).to eq utc_time.day
    expect(kraken_time.hour).to eq utc_time.hour
  end

  it "gets list of tradeable assets" do
    expect(client.assets).to respond_to :XXBT
  end

  it "gets list of asset pairs" do
    expect(client.asset_pairs).to respond_to :XXBTZEUR
  end

  it "gets public ticker data for given asset pairs" do
    result = client.ticker(pair: 'XXBTZEUR, XXBTZGBP')
    expect(result).to respond_to :XXBTZEUR
    expect(result).to respond_to :XXBTZGBP
  end

  it "gets order book data for a given asset pair" do
    order_book = client.order_book(pair: 'XXBTZEUR')
    expect(order_book.XXBTZEUR).to respond_to :asks
  end

  it "gets an array of trades data for a given asset pair" do
    trades = client.trades(pair: 'XXBTZEUR')
    expect(trades.XXBTZEUR).to be_instance_of(Array)
  end

  it "gets an array of spread data for a given asset pair" do
    spread = client.spread(pair: 'XXBTZEUR')
    expect(spread.XXBTZEUR).to be_instance_of(Array)
  end

end
