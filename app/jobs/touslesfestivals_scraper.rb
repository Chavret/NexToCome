require 'open-uri'
require 'nokogiri'

class TouslesfestivalsJob < ApplicationJob
  queue_as :default

  def perform # Do something later
    touslesfestivals_scraper(open("http://www.touslesfestivals.com/agenda/liste"))
    i = 1
    35.times do
    touslesfestivals_scraper(open("http://www.touslesfestivals.com/agenda/liste?page=#{i}"))
    i += 1
    end
  end

  def touslesfestivals_scraper(html_file)
    html_doc = Nokogiri::HTML(html_file)
    html_doc.search('.agenda-item-wrapper').each do |element|
    title = element.search(".event-title").text #headline
    date =  element.search("time").text #date
    info = element.search("li").text #description
    city =  element.search('.event-lieu').text.gsub(/\s+/, " ").strip #location
    event = Event.new(
        occurs_at: date,
        headline_initial: "Début du festival #{title} de #{city}",
        description: info,
        headline: "#{description1} - #{description2}, température de #{description3} à #{description4} degrés",
        sub_category: SubCategory.find_by(name: 'Musique'),
        status: "Pending",
        # category: Category.find_by_name('Culture')
        )
    p event.save!
    end
  end

end
