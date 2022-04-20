Gem::Specification.new do |s|
  s.name = 'teal_rb'
  s.version     = '0.1.0'
  s.licenses    = ['MIT']
  s.summary     = 'A DSL for building Algorand applications'
  s.authors     = ['Joe Polny']
  s.email       = 'joepolny+dev@gmail.com'
  s.files       = ['lib/teal.rb']
  s.homepage    = 'https://github.com/joe-p/tealrb'
  s.metadata    = { 'source_code_uri' => 'https://github.com/joe-p/tealrb',
                    'rubygems_mfa_required' => 'true' }
  s.add_runtime_dependency 'method_source'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'yard'
end
