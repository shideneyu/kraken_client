module KrakenClient
  module Requests
    module Content
      class Header

        attr_accessor :config, :endpoint_name, :options, :url

        def initialize(config, endpoint_name, options, url)
          @config          = config
          @endpoint_name   = endpoint_name
          @url             = url

          @options         = options
          @options[:nonce] = nonce
        end

        def call
          {
            'API-Key' => config.api_key,
            'API-Sign' => generate_signature,
          }
        end

        private

        ## Security

        # Generate a 64-bit nonce where the 48 high bits come directly from the current
        # timestamp and the low 16 bits are pseudorandom. We can't use a pure [P]RNG here
        # because the Kraken API requires every request within a given session to use a
        # monotonically increasing nonce value. This approach splits the difference.
        def nonce
          high_bits = (Time.now.to_f * 10000).to_i << 16
          low_bits  = SecureRandom.random_number(2 ** 16) & 0xffff
          (high_bits | low_bits).to_s
        end

        def encoded_options
          uri = Addressable::URI.new
          uri.query_hash = options
          uri.query
        end

        def generate_signature
          key = Base64.decode64(config.api_secret)
          message = generate_message
          generate_hmac(key, message)
        end

        def generate_message
          digest = OpenSSL::Digest.new('sha256', options[:nonce] + encoded_options).digest
          url.split('.com').last + digest
        end

        def generate_hmac(key, message)
          Base64.strict_encode64(OpenSSL::HMAC.digest('sha512', key, message))
        end
      end
    end
  end
end
