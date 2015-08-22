module KrakenClient
  module Requests
    module Content
      class Body

        attr_reader :post_data

        def initialize(post_data)
          @post_data = post_data
        end

        def call
          post_data
        end
      end
    end
  end
end
