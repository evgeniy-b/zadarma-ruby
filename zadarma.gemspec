Gem::Specification.new do |s|
  s.name          = "zadarma"
  s.version       = "0.0.4"
  s.date          = "2022-04-18"
  s.summary       = "zadarma.com api ruby interface"
  s.description   = ""
  s.authors       = ["Eugeniy Belyaev", "Devin Gaffney"]
  s.email         = "eugeniy.b@gmail.com"
  s.files         = `git ls-files -z`.split("\x0")
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.homepage      = "https://github.com/evgeniy-b/zadarma-ruby"
  s.license       = "MIT"

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency "json"
  s.add_dependency "faraday"
  s.add_dependency "activesupport"
end
