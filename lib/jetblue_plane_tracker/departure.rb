module JetBluePlaneTracker
	class Departure < Travel

		def initialize(airport, scheduled_takeoff, actual_takeoff, terminal, gate, temperature)
			super(airport, scheduled_takeoff, actual_takeoff, terminal, gate, temperature)
		end
		
		class << self

			def parse(leg)
				airport 			= 	leg['origin']
				scheduled_takeoff 	= 	leg['scheduledDepart']
				actual_takeoff 		=	leg['actualDepart']
				terminal 			= 	leg['originTerminal']
				gate 				=	leg['originGate']
				temperature 		= 	leg['originTemperature']

				new(airport, scheduled_takeoff, actual_takeoff, terminal, gate, temperature)
			end
		end

	end
	
end