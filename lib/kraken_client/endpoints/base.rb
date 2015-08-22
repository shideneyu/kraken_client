module KrakenClient
  module Endpoints
    class Base

      attr_accessor :config, :options

      def initialize(config, options = {})
        @config  = config
        @options = options

        set_methods
      end

      def request_manager
        @request_manager ||= KrakenClient::Requests::Base.build(config, type)
      end

      private

      def set_methods
        endpoint_names.each do |name|
           self.class.send(:define_method, name.downcase) do |args = {}|
            perform(name.to_s, args)
          end
        end      
      end

      def type
        @type ||= self.class.name.demodulize
      end
    end
  end
end
