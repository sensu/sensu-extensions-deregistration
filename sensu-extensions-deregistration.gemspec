# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "sensu-extensions-deregistration"
  spec.version       = "1.0.0"
  spec.authors       = ["Sensu Inc"]
  spec.email         = ["<support@sensu.io>"]
  
  spec.summary       = "The Sensu Core built-in deregistration handler"
  spec.description   = "The Sensu Core built-in deregistration handler"
  spec.homepage      = "https://github.com/sensu/sensu-extensions-deregistration"
  
  spec.files         = Dir.glob('{bin,lib}/**/*') + %w(LICENSE README.md CHANGELOG.md)
  spec.require_paths = ["lib"]
  
  spec.add_dependency "sensu-extension"
  
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sensu-logger"
  spec.add_development_dependency "sensu-settings"
  spec.add_development_dependency "webmock"
end
