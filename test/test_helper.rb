require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require_relative File.join 'support', 'coverage'
require_relative File.join '..', 'lib', 'kraken_client'
require 'spectus'
require 'vcr'
require 'webmock'

include WebMock::API

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock # or :fakeweb
end

# Testing Private Endpoints
KrakenClient.configure do |config|
  config.api_key    = ENV['KRAKEN_API_KEY']    || 'COMPUTED'
  config.api_secret = ENV['KRAKEN_API_SECRET'] ||'COMPUTED'
end
