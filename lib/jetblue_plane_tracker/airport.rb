 module JetBluePlaneTracker

  class Airport

    include HTTParty
    base_uri "airport-data.com/api"

    attr_accessor :icao, :iata, :name, :location, :country, :country_code, :longitude, :latitude

    def initialize(icao, iata, name, location, country, country_code, longitude, latitude)
      self.icao           =   icao
      self.iata           =   iata
      self.name           =   name
      self.location       =   location
      self.country        =   country
      self.country_code   =   country_code
      self.longitude      =   longitude
      self.latitude       =   latitude
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
        "icao" => self.icao,
        "iata" => self.iata,
        "name" => self.name,
        "location" => self.location,
        "country" => self.country,
        "country_code" => self.country_code,
        "longitude" => self.longitude,
        "latitude" => self.latitude
      }.to_json
    end

    class << self

      def parse_airport_iata(airport_name)
        airport_name[/[(][a-zA-Z]*[)]/, 0].gsub(/[()]/, "").strip.to_s
      end

      def find(options={})
        response = self.get("/ap_info.json", query: options)
        if response["status"] == 200
          new(response["icao"], response["iata"], response["name"], response["location"], 
              response["country"], response["country_code"], response["longitude"], response["latitude"])
        else
          raise response["error"]
        end
      end

    end
    
  end

end
