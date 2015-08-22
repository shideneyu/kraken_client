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

        params[:headers] = header_content(options).call
        params[:body]    = body_content.call

        params
      end

      def content_manager
        KrakenClient::Requests::Content
      end

      def header_content(options = nil)
        @content ||= content_manager::Header.new(config, endpoint_name, options, url)
      end

      def body_content
        content_manager::Body.new(header_content.send(:encoded_options))
      end

    end
  end
end