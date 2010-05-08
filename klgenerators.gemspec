Gem::Specification.new do |s|
  s.name        = "klgenerators"
  s.version     = '0.0.0'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["James Stewart"]
  s.email       = ["james@ketlai.co.uk"]
  s.summary     = "Saving us a few precious minutes"
  s.description = "Custom generators for commonly used Ket Lai code"
 
  s.required_rubygems_version = ">= 1.3.6"
 
  s.add_development_dependency "rails"
 
  s.files        = Dir.glob("lib/**/*")
  s.require_path = 'lib'
end