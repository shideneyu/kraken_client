module KrakenClient
  class Exception < StandardError; end
  class ArgumentError < Exception; end
  class ErrorResponse < Exception; end
  class NotImplemented < Exception; end
  class MissingApiKeys < Exception; end
end
