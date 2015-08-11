 module JetBluePlaneTracker

  class Airport

    attr_accessor :iata, :icao, :name, :city, :country, :latitude, :longitude, :altitude, :timezone, :dst

    def initialize(iata, icao, name, city, country, latitude, longitude, altitude, timezone, dst)
      self.iata           =   iata
      self.icao           =   icao
      self.name           =   name
      self.city           =   city
      self.country        =   country
      self.longitude      =   longitude.to_f
      self.latitude       =   latitude.to_f
      self.altitude       =   altitude
      self.timezone       =   timezone
      self.dst            =   dst
    end

    def to_s
      str = ""
      self.instance_variables.each do |var| 
        name = var.to_s.gsub!("@", "")
        key = send(name)
        str += "#{name}: #{key}, "
      end
      str[0..str.length-3]
    end

    def to_json
      {
        iata: self.iata,
        icao: self.icao,
        name: self.name,
        city: self.city,
        country: self.country,
        latitude: self.latitude,
        longitude: self.longitude,
        altitude: self.altitude,
        timezone: self.timezone,
        dst: self.dst
      }
    end

    class << self

      def parse_airport_iata(airport_name)
        airport_name[/[(][a-zA-Z]*[)]/, 0].gsub(/[()]/, "").strip.to_s
      end

      def find_by_iata(iata_code)
        data = get_json
        airport_data = data[iata_code]
        new_object_instance(airport_data)
      end

      def search(search_text)
        data = get_json
        airports = []
        data.each do |d|
          airport_data = d[1]
          airports << new_object_instance(airport_data) if airport_data.has_value?(search_text)
        end
        airports
      end

      def all
        data = get_json
        airports = []
        data.each do |airport_data|
          airports << new_object_instance(airport_data[1])
        end
        airports
      end

      def get_json
        file = File.read(File.expand_path('../../data/airports.json', __FILE__))
        JSON.parse(file)
      end

      def new_object_instance(airport_data)
        new(airport_data["iata"], airport_data["icao"], airport_data["name"], 
            airport_data["city"], airport_data["country"], airport_data["latitude"], 
            airport_data["longitude"], airport_data["altitude"], airport_data["timezone"], 
            airport_data["dst"])
      end

    end
    
  end

end
