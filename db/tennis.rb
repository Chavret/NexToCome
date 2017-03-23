require 'open-uri'
require 'nokogiri'


html_file = open("https://fr.wikipedia.org/wiki/Saison_2017_de_l'ATP")

# def tennis_scraper(html_file)
html_doc = Nokogiri::HTML(html_file)
  html_doc.search('tbody tr').each do |element|
    puts title = element.search("td").text
  end
# end
