Gem::Specification.new do |s|
  s.name = 'polyrex-headings'
  s.version = '0.1.1'
  s.summary = 'polyrex-headings'
  s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb']
  s.add_dependency('polyrex') 
  s.signing_key = '../privatekeys/polyrex-headings.pem'
  s.cert_chain  = ['gem-public_cert.pem']
end
