require 'open-uri'
require 'nokogiri'

class JeuxvideosJob < ApplicationJob
  queue_as :default

  def perform # Do something later
    html_file5 = open("https://www.senscritique.com/jeuxvideo/prochaines-sorties")
    jeuxvideos_scraper(html_file)
  end

  def jeuxvideos_scraper(html_file)
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('.elpr-content').each do |element|
      puts title = element.search(".elco-anchor").text.gsub(/\s+/, " ").strip
      date = element.search("time").text.gsub(/\s+/, " ").strip
      topo = element.search(".elco-description").text.gsub(/\s+/, " ").strip
      if date != nil
        event = Event.new(
        occurs_at: date,
        headline_initial: title,
        sub_category_name: "Jeux vidéos",
        )
      event.save
     end
   end

  end
end
