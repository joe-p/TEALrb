Gem::Specification.new do |s|
  s.name = 'tealrb'
  s.required_ruby_version = '>= 2.7'
  s.version     = '0.2.0'
  s.licenses    = ['MIT']
  s.summary     = 'A DSL for building Algorand applications'
  s.authors     = ['Joe Polny']
  s.email       = 'joepolny+dev@gmail.com'
  s.files       = Dir['lib/**/*.rb']
  s.homepage    = 'https://github.com/joe-p/tealrb'
  s.metadata    = { 'source_code_uri' => 'https://github.com/joe-p/tealrb',
                    'rubygems_mfa_required' => 'true' }
  s.add_runtime_dependency 'method_source', ['~> 1.0']
  s.add_runtime_dependency 'rubocop', ['~> 1.27']
  s.add_development_dependency 'minitest', ['~> 5.15']
  s.add_development_dependency 'pry', ['~> 0.14.1']
  s.add_development_dependency 'rake', ['~> 13.0.1']
  s.add_development_dependency 'redcarpet', ['~> 3.5.1']
  s.add_development_dependency 'rubocop-minitest', ['~> 0.19.1']
  s.add_development_dependency 'yard', ['~> 0.9.27']
end
