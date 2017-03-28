require 'open-uri'
require 'nokogiri'

class JeuxvideosJob < ApplicationJob
  queue_as :default

  def perform # Do something later
    html_file = open("https://www.senscritique.com/jeuxvideo/prochaines-sorties")
    jeuxvideos_scraper(html_file)
  end

  def jeuxvideos_scraper(html_file)
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('.elpr-content').each do |element|
      puts title = element.search(".elco-anchor").text.gsub(/\s+/, " ").strip
      p date = element.search("time").text
      topo = element.search(".elco-description").text.gsub(/\s+/, " ").strip
      if date != ""
        event = Event.new(
        occurs_at: date,
        headline_initial: title,
        headline: title,
        sub_category: SubCategory.find_by(name: 'Jeux vidéos'),
        # category: Category.find_by_name('Culture'),
        status: "Pending"
        )
      p event
      p event.save!
     end
   end

  end
end
