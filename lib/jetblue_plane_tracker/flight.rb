module JetBluePlaneTracker
	class Flight
		attr_accessor :origin, :destination, :legs

		def initialize(origin, destination, legs)
			self.origin = Airport.find(iata: Airport.parse_airport_iata(origin))
			self.destination = Airport.find(iata: Airport.parse_airport_iata(destination))
			self.legs = legs
		end

		def to_s
			"#{origin} -> #{destination}\n [#{legs}]"
		end

		def all_legs
			self.legs.each{ |leg| leg.to_json }
		end

		def to_json
			{
				"origin" => self.origin.to_json,
				"destination" => self.destination.to_json,
				"legs" => self.legs.map{ |leg| leg.to_json }
			}
		end

	end
	
end