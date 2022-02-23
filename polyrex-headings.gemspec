Gem::Specification.new do |s|
  s.name = 'polyrex-headings'
  s.version = '0.3.0'
  s.summary = 'Parses a raw Polyrex document containing Markdown ' \
      + ' style headings'
  s.authors = ['James Robertson']
  s.files = Dir['lib/polyrex-headings.rb']
  s.add_runtime_dependency('polyrex', '~> 1.4', '>=1.4.0')
  s.signing_key = '../privatekeys/polyrex-headings.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'digital.robertson@gmail.com'
  s.homepage = 'https://github.com/jrobertson/polyrex-headings'
  s.required_ruby_version = '>= 2.3.0'
end
