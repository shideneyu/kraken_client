require 'find'
require 'active_support/inflector'

Find.find('./lib').select { |p| /.*\.rb$/ =~ p }.each do |path|
  require(path)
end

module KrakenClient
  extend KrakenClient::Configurable

  def self.load(params = {})
    KrakenClient::Application.new(params)
  end

end
