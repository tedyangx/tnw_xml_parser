Gem::Specification.new do |s|
  s.name        = "tnw_xml_parser"
  s.version     = "0.0.3"
  s.summary     = "TnwXmlParser"
  s.description = "This gem provides a ruby class called TnwXmlParser to do XML parsing."
  s.authors     = ["T Yang"]
  s.email       = "ted.yang@clio.com"
  s.files       = ["lib/tnw_xml_parser.rb"]
  s.homepage    = "https://github.com/tedyangx/tnw_xml_parser"
  s.license     = "MIT"

  s.add_runtime_dependency "nokogiri", "~> 1.10"

  s.add_development_dependency "rspec", "~> 3.9"
  s.add_development_dependency "pry", "~> 0.13"
end
