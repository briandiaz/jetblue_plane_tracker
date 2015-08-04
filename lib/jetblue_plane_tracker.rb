require 'json'
require 'httparty'
require File.expand_path('../jetblue_plane_tracker/airport', __FILE__)
require File.expand_path('../jetblue_plane_tracker/flight', __FILE__)
require File.expand_path('../jetblue_plane_tracker/leg', __FILE__)
require File.expand_path('../jetblue_plane_tracker/travel', __FILE__)
require File.expand_path('../jetblue_plane_tracker/departure', __FILE__)
require File.expand_path('../jetblue_plane_tracker/arrival', __FILE__)
require File.expand_path('../jetblue_plane_tracker/tracker', __FILE__)

jbtracker = JetBluePlaneTracker::Tracker.new
flights = jbtracker.flight_status(flight: 37, date: "2015-07-29")
puts flights.first.legs.first.departure.airport.name