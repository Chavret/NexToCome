require 'open-uri'
require 'nokogiri'


html_file = open("http://www.offi.fr/expositions-musees/prochainement.html")


html_doc = Nokogiri::HTML(html_file)
  html_doc.search('.oneRes').each do |element|
  puts title = element.search(".eventTitle").text #headline
  puts type = element.search("li:nth-child(1)").text #sub_category
  puts info = element.search("li:nth-child(2)").text #description-localisation
  puts date1 = element.search("li:nth-child(3)").text #date de début si date de début
  puts date2 = element.search("li:nth-child(4)").text #headline #date de début si date de début
  puts date3 = element.search("li:nth-child(5)").text #headline #date de fin si date de fin
  puts "---------------------------------------------"
  event = {
    occurs_at: date2,
    headline_initial: title,
    sub_category_name: "Beaux-Arts",
    }
end





