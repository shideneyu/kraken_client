Gem::Specification.new do |spec|
  spec.name          = 'kraken_client'
  spec.version       = File.read('VERSION.semver').chomp
  spec.authors       = ['Sidney SISSAOUI']
  spec.email         = ['shideneyu@gmail.com']
  spec.description   = %q{'Wrapper for Kraken Exchange API'}
  spec.summary       = %q{'Wrapper for Kraken Exchange API'}
  spec.homepage      = 'https://github.com/shideneyu/kraken_client'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/).delete_if { |f| f =~ /\.gem$/ }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'spectus'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'codeclimate-test-reporter'

  spec.add_dependency 'httparty'
  spec.add_dependency 'hashie'
  spec.add_dependency 'addressable'

  spec.add_runtime_dependency 'activesupport', '~> 3.2'

end
