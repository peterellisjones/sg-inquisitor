Gem::Specification.new do |s|
  s.name        = 'sg-inquisitor'
  s.version     = '0.0.0'
  s.date        = '2013-09-20'
  s.summary     = "Cleans up your security groups"
  s.description = ""
  s.authors     = ["Peter Ellis Jones"]
  s.email       = 'pj@ukoki.com'
  s.files       = ["lib/sg-inquisitor.rb"]
  s.require_paths = ["lib"]
  s.homepage    = ''
  s.license     = 'MIT'
  s.add_dependency('aws-sdk', [">= 0"])
end