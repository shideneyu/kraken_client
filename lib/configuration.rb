module KrakenClient
  class Configuration

    attr_accessor :api_key, :api_secret, :base_uri, :limiter_interface,
                  :api_version, :tier, :limiter, :limit_current_count

    def initialize
      @api_key             = ENV['KRAKEN_API_KEY']
      @api_secret          = ENV['KRAKEN_API_SECRET']
      @base_uri            = 'https://api.kraken.com'
      @api_version         = 0
      @limiter             = true
      @tier                = 2

      @limiter_interface ||= KrakenClient::Requests::Limiter.new(self)
    end

  end
end
