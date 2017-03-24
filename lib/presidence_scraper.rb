require 'open-uri'
require 'nokogiri'


t = 20/03/2017


def presidence_scraper(html_file)
  html_file = open("http://www.elysee.fr/Agenda/index/253/agenda-de-m-le-president-de-la-republique-du-lundi-20-mars-au-dimanche-26-mars-2017")
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



# 4.times do
#     t += 7*24*60*60
#     scraped_week = t.strftime("sem-%Y-%m-%d/")
#     html_file = open("http://www.allocine.fr/film/agenda/#{scraped_week}")
#     allocine_week_scraper(html_file)
#   end
