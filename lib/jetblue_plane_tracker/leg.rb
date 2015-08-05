module JetBluePlaneTracker
	class Leg
		attr_accessor :number, :date, :departure, :arrival, :status, :progress, :current_location

		def initialize(number, date, departure, arrival, status)
			self.number = number
			self.date = date
			self.departure = departure
			self.arrival = arrival
			self.status = status
			self.progress = flight_tracker_progress
			self.current_location = current_location
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
				"progress" => self.progress,
				"current_location" => current_location
			}.to_json
		end

		def flight_tracker_progress
			min_progress = 0
			max_progress = 1
			progress = 0			
			# Arrival airport timezone (UTC)
			utc = self.arrival.airport.timezone
			# Convert dates to the actual arrival airport timezone
			current_datetime = DateTime.now.change(:offset => utc.to_s).to_i

			actual_arrival = self.arrival.actual_takeoff.change(:offset => utc.to_s).to_i

			actual_departure = self.departure.actual_takeoff.change(:offset => utc.to_s).to_i

			progress = (current_datetime - actual_departure).to_f / (actual_arrival - actual_departure).to_f
			
			# Check if progress is minor than min progress or max progress
			progress = (progress < min_progress) ? min_progress : progress
			progress = (progress > max_progress) ? max_progress : progress
			
			progress * 100
		end

		# To be tested in different coordinates
		def current_location
			departude_longitude = self.departure.airport.longitude.to_f
			arrival_longitude = self.arrival.airport.longitude.to_f
			current_progress = self.progress / 100
			
			current_latitude = self.arrival.airport.latitude
			current_longitude = get_plane_longitude(departude_longitude, arrival_longitude, current_progress)

			{latitude: current_latitude, longitude: current_longitude}
		end

		private
			def get_plane_longitude(departurelng, arrivallng, progress)
				(progress > 0) ? ((arrivallng + ((1-progress)*arrivallng)) - progress) : departurelng
			end

	end
	
end