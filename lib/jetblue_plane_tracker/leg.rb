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


		def current_location

		    departure = self.departure.airport
		    arrival = self.arrival.airport
		    current_progress = self.progress/100

		    latitude = get_plane_coordinate(departure.latitude, arrival.latitude, current_progress)
		    longitude = get_plane_coordinate(departure.longitude, arrival.longitude, current_progress)

		    {
		        latitude: latitude,
		        longitude: longitude
		    }
		end

		private
			def get_plane_coordinate(coordinate_x, coordinate_y, progress)
				new_coordinate = 0

				if(coordinate_x != coordinate_y)
			        new_coordinate = coordinate_x + progress * (coordinate_y - coordinate_x)
			    else
			        new_coordinate = coordinate_x
			    end

			    new_coordinate
			end

	end
	
end