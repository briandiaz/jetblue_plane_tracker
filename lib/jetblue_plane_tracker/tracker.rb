module JetBluePlaneTracker

	class Tracker
		include HTTParty
		base_uri "http://www.jetblue.com/flightstatus"

		attr_accessor :params

		def initialize(params={})
			self.params = params
		end
		
		def flights
			data = get_data
			flight_date = self.params.has_key?("date") ? options[:date] : Date.today
			flights = []
			legs = []
			data['flights'].each do |flight|
				flight['legs'].each do |leg|
					lg = Leg.new(leg["flightNo"], flight_date,
									Departure.parse(leg), Arrival.parse(leg), leg['flightStatus'])
					legs << lg
				end
				fl = Flight.new(flight["tripOrigin"], flight["tripDestination"], legs)
				flights << fl
			end
			flights
		end

		alias_method :get_flights, :flights

		private

			def get_data
				self.class.get("/FlightStatusData.aspx", query: self.params)
			end

	end
end