# JetBlue Plane Tracker
A Ruby wrapper for JetBlue flights status tracker.

## Installation

Install the gem via the CLI

```
	gem install jetblue_plane_tracker
```

or 

Just add the following into your Gemfile and run `bundle`.

```ruby
	gem 'jetblue_plane_tracker'
```

## Usage

Instantiate the tracker

```ruby
jbtracker = JetBluePlaneTracker::Tracker.new
```

Get a flight status by the departure and arrival city and its date: 

```ruby
flights = jbtracker.flight_status(origin: "SFO", destination: "JFK", date: "2015-31-07")
```
Get a flight status by the flight number and its date: 
```ruby
flights = jbtracker.flight_status(flight: 37, date: "2015-29-07")
```

Print flights by:
```ruby
flights.each { |flight| puts flight }
```
Print flights into json by:
```ruby
flights.each { |flight| puts flight.to_json }
```
Convert to JSON by:
```ruby
flights.map { |flight| flight.to_json }
```

## Suggestions

* Date Format is ```yyyy-dd-mm```
* Permited params are:
	* origin
	* destination
	* date
	* flight
	* date
* Params origin and destination are valid [IATA airport codes][iata]


[iata]: https://en.wikipedia.org/wiki/International_Air_Transport_Association_airport_code