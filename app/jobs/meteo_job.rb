require 'json'
require 'open-uri'


class AllocineJob < ApplicationJob
  queue_as :default

  def perform
  # Do something later
  # latitude = 48.866667
  # longitude = 2.333333
  # url = 'https://api.darksky.net/forecast/92d8f636e4c7092e7f955e1b3b4ff48a/#{latitude},#{longitude}'
  url = 'https://api.darksky.net/forecast/92d8f636e4c7092e7f955e1b3b4ff48a/48.866667,2.333333?units=si&lang=fr'
  meteo_serialized = open(url).read
  meteo_scraper(meteo_serialized)
  end

  def meteo_scraper(meteo_serialized)
    corresponding_icons = { "clear-day" => "clear_day.svg",
                        "clear-night" => "clear_night.svg",
                        "rain" => "rain.svg",
                        "snow" => "snow.svg",
                        "sleet" => "sleet.svg",
                        "wind" => "wind.svg",
                        "fog" => "fog.svg",
                        "cloudy" => "cloudy.svg",
                        "partly-cloudy-day" => "partly_cloudy_day.svg",
                        "sun" => "sun.svg",
                        "partly-cloudy-night" => "partly_cloudy_night.svg" }
    info = JSON.parse(meteo_serialized)
    current_time = info["currently"]["time"]
    i = 0
    until i == 8
      date = Time.at(info["daily"]["data"][i]["time"]).strftime("%d %m %Y")
      description1 = info["daily"]["data"][i]["icon"]
      description2 = info["daily"]["data"][i]["summary"].delete(".")
      description3 =info["daily"]["data"][i]["temperatureMin"].round
      description4 =info["daily"]["data"][i]["temperatureMax"].round
      event = Event.new = {
          occurs_at: date,
          headline_initial: "#{description1} - #{description2}, température de #{description3} à #{description4} degrés",
          sub_category_name: "Météo",
          }
      event.save
      i +=1
    end
  end

end