Gem::Specification.new do |s|
  s.name = 'polyrex-headings'
  s.version = '0.1.8'
  s.summary = 'polyrex-headings'
  s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb']
  s.add_runtime_dependency('polyrex', '~> 1.0', '>=1.0.1') 
  s.signing_key = '../privatekeys/polyrex-headings.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/polyrex-headings'
  s.required_ruby_version = '>= 2.1.0'
end
