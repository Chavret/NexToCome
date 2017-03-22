require 'open-uri'
require 'nokogiri'

html_file = open("http://www.elysee.fr/Agenda/index/253/agenda-de-m-le-president-de-la-republique-du-lundi-20-mars-au-dimanche-26-mars-2017")
html_doc = Nokogiri::HTML(html_file)


def presidence_scraper(html_file)

  html_doc.search('.agenda-day').each do |element|
    date = element.search(".day-numeric").text + " " + element.search(".day-month").text
    title = element.search(".event-text").text.gsub(/\s+/, " ").strip
    event = {
    occurs_at: date,
    headline: title,
    sub_category_name: "Politique",
    }
  end

end

html_doc.search('.agenda-day').each do |element|
    puts element.search(".day-numeric").text + " " + element.search(".day-month").text #occurs_at
    puts element.search(".event-text").text.gsub(/\s+/, " ").strip #headline
    puts "------------------------------------------"
  end
