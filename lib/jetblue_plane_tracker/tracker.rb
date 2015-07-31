module JetBluePlaneTracker

	class Tracker
		include HTTParty
		base_uri "http://www.jetblue.com/flightstatus"

		def initialize()

		end
		
		def flight_status(params={})
			data = get_data(params)
			flight_date = params.has_key?("date") ? options[:date] : Date.today
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

		alias_method :find_flight, :flight_status

		private

			def get_data(params)
				self.class.get("/FlightStatusData.aspx", query: params)
			end

	end
end