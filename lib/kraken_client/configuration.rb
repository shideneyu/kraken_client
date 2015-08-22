module KrakenClient
  class Configuration

    attr_accessor :api_key, :api_secret, :base_uri, :api_version

    def initialize
      @api_key     = ENV['KRAKEN_API_KEY']
      @api_secret  = ENV['KRAKEN_API_SECRET']
      @base_uri    = 'https://api.kraken.com'
      @api_version = 0
    end

  end
end
