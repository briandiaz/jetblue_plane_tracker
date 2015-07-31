module JetBluePlaneTracker
	class Travel
		attr_accessor :airport, :scheduled_takeoff, :actual_takeoff, :terminal, :gate, :temperature

		def initialize(airport, scheduled_takeoff, actual_takeoff, terminal, gate, temperature)
			super()
			self.airport = Airport.find(iata: Airport.parse_airport_iata(airport))
			self.scheduled_takeoff = scheduled_takeoff
			self.actual_takeoff = actual_takeoff
			self.terminal = terminal
			self.gate = gate
			self.temperature = temperature
		end

		def to_s
			"#{type}-> Airport: #{airport.name} Scheduled Take-Off: #{scheduled_takeoff} - Actual Take-Off: #{actual_takeoff} [Terminal: #{terminal}, Gate: #{gate}, Temperature: #{temperature}]"
		end


		def to_json
			{
				"airport" => self.airport.to_json,
				"scheduled_takeoff" => self.scheduled_takeoff,
				"actual_takeoff" => self.actual_takeoff,
				"terminal" => self.terminal,
				"gate" => self.gate,
				"temperature" => self.temperature
			}.to_json
		end

		def type
			self.class.name.sub!("JetBluePlaneTracker::", "")
		end
		
	end
	
end