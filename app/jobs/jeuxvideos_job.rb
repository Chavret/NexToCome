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
        p occurs_at: date_translater_jeuxvideos(date),
        headline_initial: title,
        headline: "Sortie du jeu #{title}",
        sub_category: SubCategory.find_by(name: 'Jeux vidéos'),
        # category: Category.find_by_name('Culture'),
        status: "Valid"
        )
      p event
      p event.save!
     end
   end
  end

  def date_translater_jeuxvideos(date)
      array = date.split(/\W+/)
      translation = {
      janvier: 'January',
      fevrier: 'February',
      mars: 'March',
      avril: 'April',
      mai: 'May',
      juin: "June",
      juillet: 'July',
      aout: 'August',
      septembre: 'September',
      octobre: 'October',
      novembre: 'November',
      decembre: 'December'
    }
    date = [array[0], translation[array[1].to_sym], array[2]].join(' ')
  end
end
