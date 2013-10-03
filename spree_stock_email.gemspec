# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_stock_email'
  s.version     = '0.0.7'
  s.summary     = 'Send an email when a product is in stock.'
  s.description = 'Send an email when a product is in stock.'
  s.required_ruby_version = '>= 1.9.3'

  s.author    = 'Richard Hart'
  s.email     = 'richard@ur-ban.com'
  # s.homepage  = 'http://www.spreecommerce.com'

  #s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '~> 1.2.2'

end
