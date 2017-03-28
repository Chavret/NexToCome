require 'open-uri'
require 'nokogiri'

class PresidenceJob < ApplicationJob
  queue_as :default

  def perform


    html_file = open("http://www.elysee.fr/Agenda")
    # recuperer ici le link rel => vers la bonne semaine
    presidence_scraper(html_file)
  end

  def presidence_scraper(html_file)
    p html_doc = Nokogiri::HTML(html_file)
    p html_doc.search('.agenda-day')
    html_doc.search('.agenda-day').each do |element|
      p date = element.search(".day-numeric").text + " " + element.search(".day-month").text
      title = element.search(".event-text").text.gsub(/\s+/, " ").strip
      event = Event.new(
      occurs_at: date,
      headline_initial: title,
      headline: title,
      sub_category: SubCategory.find_by(name: 'Politique'),
      # category: Category.find_by_name('Société'),
      status: "Pending"
      )
      p event
      p event.save!
    end
  end

end
