Gem::Specification.new do |s|
  s.name          = "zadarma"
  s.version       = "0.0.2"
  s.date          = "2015-10-07"
  s.summary       = "zadarma.com api ruby interface"
  s.description   = ""
  s.authors       = ["Eugeniy Belyaev"]
  s.email         = "eugeniy.b@gmail.com"
  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.homepage      = "https://github.com/zhekanax/zadarma-ruby"
  s.license       = "MIT"

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency "json"
  s.add_dependency "faraday"
  s.add_dependency "activesupport"
end