$:.push File.expand_path("../lib", __FILE__)

require "jetblue_plane_tracker/version"

Gem::Specification.new do |s| 
  s.name = "jetblue_plane_tracker"
  s.version = "0.1.0"
  s.author = "Brian Díaz"
  s.email = "brian@briandiaz.me"
  s.homepage = "https://github.com/briandiaz/jetblue_plane_tracker"
  s.platform = JetBluePlaneTracker::VERSION
  s.description = "A Ruby wrapper for JetBlue flights status API"
  s.summary = "A Ruby wrapper for JetBlue flights status API"
  s.files = Dir["lib/**/*"] + ["README.md"]
  s.test_files = Dir["spec/**/*"]
  s.add_dependency('httparty', '>= 0.12.0')
  s.add_dependency('json', '>= 1.5')
end