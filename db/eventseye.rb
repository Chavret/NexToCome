require 'open-uri'
require 'nokogiri'


html_file = open("http://www.eventseye.com/fairs/c0_salons_france.html") #puis +=1 à chaque page
html_doc = Nokogiri::HTML(html_file)

html_doc.search('.td').each do |element|
  puts element.search(".first").text.gsub(/\s+/, " ").strip #headline
  # puts element.children[3].text # only "confirmed" should be selected
  # puts element.children[4].text # only "confirmed" should be selected
  # puts "------------------------------------------"
end

  # # puts "------------------------------------------"

  # puts element.search(".elco-description").text.gsub(/\s+/, " ").strip #description
  # puts "------------------------------------------"

