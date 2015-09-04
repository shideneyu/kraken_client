module KrakenClient
  module Requests
    class Post < Base

      def call(url, endpoint_name, options)
        super

        @url           = url
        @endpoint_name = endpoint_name

        response       = HTTParty.post(url, params(options)).parsed_response
        response['error'].empty? ? response['result'] : response['error']
      end

      private

      def params(options = {})
        params           = {}

        header_content   = content_manager::Header.new(config, endpoint_name, options, url)

        params[:headers] = header_content.call
        params[:body]    = body_content(header_content).call

        params
      end

      def content_manager
        KrakenClient::Requests::Content
      end

      def body_content(header_content)
        content_manager::Body.new(header_content.send(:encoded_options))
      end

    end
  end
end
