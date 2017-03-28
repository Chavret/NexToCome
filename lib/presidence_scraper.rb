require 'open-uri'
require 'nokogiri'



  html_file = open("http://www.elysee.fr/Agenda")

  def presidence_scraper(html_file)

  html_doc = Nokogiri::HTML(html_file)

  html_doc.search('.agenda-day').each do |element|
    puts date = element.search(".day-numeric").text + " " + element.search(".day-month").text
    puts title = element.search(".event-text").text.gsub(/\s+/, " ").strip
    event = {
    occurs_at: date,
    headline_initial: title,
    sub_category_name: "Politique",
    }
  end

end


presidence_scraper(open("http://www.elysee.fr/Agenda"))
