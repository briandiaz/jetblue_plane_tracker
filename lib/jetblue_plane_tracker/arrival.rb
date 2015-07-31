module JetBluePlaneTracker
	class Arrival < Travel
		
		def initialize(airport, scheduled_takeoff, actual_takeoff, terminal, gate, temperature)
			super(airport, scheduled_takeoff, actual_takeoff, terminal, gate, temperature)
		end

		class << self

			def parse(leg)
				airport 			= 	leg['destination']
				scheduled_takeoff 	= 	leg['scheduledArrival']
				actual_takeoff 		=	leg['actualArrival']
				terminal 			= 	leg['destinationTerminal']
				gate 				=	leg['destinationGate']
				temperature 		= 	leg['destinationTemperature']

				new(airport, scheduled_takeoff, actual_takeoff, terminal, gate, temperature)
			end

		end

	end
	
end