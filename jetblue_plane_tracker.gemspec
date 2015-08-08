$:.push File.expand_path("../lib", __FILE__)

require "jetblue_plane_tracker/version"

Gem::Specification.new do |s| 
  s.name            = "jetblue_plane_tracker"
  s.version         = JetBluePlaneTracker::VERSION
  s.author          = "Brian Díaz"
  s.email           = "brian@briandiaz.me"
  s.homepage        = "https://github.com/briandiaz/jetblue_plane_tracker"
  s.platform        = Gem::Platform::RUBY
  s.licenses        = ['MIT']
  s.description     = "A Ruby wrapper for JetBlue flights status API"
  s.summary         = "This wrapper retrieves data of any flight by JetBlue Airways Corporation"
  s.files           = Dir["lib/**/*"] + ["README.md"]
  s.test_files      = Dir["spec/**/*"]
  s.add_dependency('httparty', '~> 0.12.0')
  s.add_dependency('json', '~> 1.5')
  s.add_dependency('activesupport', '>= 3.2.18')
end