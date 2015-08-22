require 'spec_helper'

describe KrakenClient::Endpoints::Private do

  before :each do
    sleep 0.3 # to prevent rapidly pinging the Kraken server
  end

  let(:kraken) { KrakenClient.load }
  let(:client) { kraken.private }

  it "gets the user's balance" do
    expect(client.balance).to be_instance_of(Hash)
  end

  pending "uses a 64 bit nonce" do
    nonce = client.send :nonce
    expect(nonce.to_i.size).to eq(8)
  end

end
