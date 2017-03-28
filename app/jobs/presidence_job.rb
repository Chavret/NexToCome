require 'open-uri'
require 'nokogiri'


class PresidenceJob < ApplicationJob
  queue_as :default

  def perform # Do something later
    html_file = open("http://www.elysee.fr/Agenda")
    presidence_scraper(html_file)
  end

  def presidence_scraper(html_file)

    html_doc = Nokogiri::HTML(html_file)
    html_doc.search('.agenda-day').each do |element|
      date = element.search(".day-numeric").text + " " + element.search(".day-month").text
      title = element.search(".event-text").text.gsub(/\s+/, " ").strip
      event = Event.new(
      occurs_at: date,
      headline_initial: title,
      sub_category_name: "Politique",
      )
      event.save
    end
  end

end