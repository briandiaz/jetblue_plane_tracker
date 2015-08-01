module JetBluePlaneTracker
	class Leg
		attr_accessor :number, :date, :departure, :arrival, :status, :progress

		def initialize(number, date, departure, arrival, status)
			self.number = number
			self.date = date
			self.departure = departure
			self.arrival = arrival 
			self.status = status
			self.progress = flight_tracker_progress
		end

		def to_s
			"##{number}\n#{departure}\n#{arrival}\n#{status}\n#{progress}"
		end

		def to_json
			{
				"number" => self.number,
				"date" => self.date,
				"departure" => self.departure.to_json,
				"arrival" =>  self.arrival.to_json,
				"status" => self.status,
				"progress" => self.progress
			}.to_json
		end

		def flight_tracker_progress
			min_progress = 0
			max_progress = 1
			progress = 0
			
			current_datetime = Time.now.to_i
			actual_arrival = Time.parse(self.arrival.actual_takeoff).to_i
			actual_departure = Time.parse(self.departure.actual_takeoff).to_i
			
			progress = (current_datetime - actual_departure).to_f / (actual_arrival- actual_departure).to_f
			
			progress = progress < min_progress ? min_progress : progress
			
			progress = progress > max_progress ? max_progress : progress
			
			progress * 100
		end

	end
	
end