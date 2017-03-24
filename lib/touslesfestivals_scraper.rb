require 'open-uri'
require 'nokogiri'


html_file = open("http://www.touslesfestivals.com/agenda/liste")

def touslesfestivals_scraper(html_file)
html_doc = Nokogiri::HTML(html_file)
  html_doc.search('.agenda-item-wrapper').each do |element|
  puts title = element.search(".event-title").text #headline
  puts date =  element.search("time").text #date
  puts info = element.search("li").text #description
  puts city =  element.search('.event-lieu').text.gsub(/\s+/, " ").strip #location
  puts "-------------------"
  event = {
      occurs_at: date,
      headline_initial: "Début du festival #{title} de #{city}",
      sub_category_name: "Musique",
      description: info,
      }
  end
end

i = 1

35.times do
  url = "http://www.touslesfestivals.com/agenda/liste?page=#{i}"
  html_file = open(url) #puis +=1 à chaque page
  touslesfestivals_scraper(html_file)
  i += 1
  end





