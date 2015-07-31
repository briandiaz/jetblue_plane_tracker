module JetBluePlaneTracker
	class Leg
		attr_accessor :number, :date, :departure, :arrival, :status

		def initialize(number, date, departure, arrival, status)
			self.number = number
			self.date = date
			self.departure = departure
			self.arrival = arrival 
			self.status = status
		end

		def to_s
			"##{number}\n#{departure}\n#{arrival}\n#{status}"
		end

		def to_json
			{
				"number" => self.number,
				"date" => self.date,
				"departure" => self.departure.to_json,
				"arrival" =>  self.arrival.to_json,
				"status" => self.status
			}.to_json
		end

	end
	
end