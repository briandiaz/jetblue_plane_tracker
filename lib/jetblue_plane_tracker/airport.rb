 module JetBluePlaneTracker

  class Airport

    attr_accessor :iata, :icao, :name, :city, :country, :latitude, :longitude, :altitude, :timezone, :dst

    def initialize(iata, icao, name, city, country, latitude, longitude, altitude, timezone, dst)
      self.iata           =   iata
      self.icao           =   icao
      self.name           =   name
      self.city           =   city
      self.country        =   country
      self.longitude      =   longitude
      self.latitude       =   latitude
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
        "iata" => self.iata,
        "icao" => self.icao,
        "name" => self.name,
        "city" => self.city,
        "country" => self.country,
        "latitude" => self.latitude,
        "longitude" => self.longitude,
        "altitude" => self.altitude,
        "timezone" => self.timezone,
        "dst" => self.dst
      }.to_json
    end

    class << self

      def parse_airport_iata(airport_name)
        airport_name[/[(][a-zA-Z]*[)]/, 0].gsub(/[()]/, "").strip.to_s
      end

      def find(options={})
        file = File.read(File.expand_path('../../data/airports.json', __FILE__))
        data = JSON.parse(file)
        airport_data = data[options[:iata]]
        new(airport_data["iata"], airport_data["icao"], airport_data["name"], 
          airport_data["city"], airport_data["country"], airport_data["latitude"], 
          airport_data["longitude"], airport_data["altitude"], airport_data["timezone"], 
          airport_data["dst"])
      end


    end
    
  end

end
