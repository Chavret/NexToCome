require 'open-uri'
require 'nokogiri'


html_file5 = open("https://www.senscritique.com/jeuxvideo/prochaines-sorties")
html_doc5 = Nokogiri::HTML(html_file5)

html_doc5.search('.elpr-content').each do |element|
  puts element.search(".elco-anchor").text.gsub(/\s+/, " ").strip #headline

  puts element.search(".elco-baseline").text.gsub(/\s+/, " ").strip

  # # puts "------------------------------------------"

  # puts element.search(".elco-description").text.gsub(/\s+/, " ").strip #description
  # puts "------------------------------------------"
end

# # td:nth-child(1) => class:"d-heading2 elco-title"
#   class :"elco-anchor"
# class: "elco-baseline elco-options"
#   datetime
# elco-baseline
# elco-description
# erra
# end

# html_doc3.search('.agenda-day').each do |element|
#   puts element.search(".day-numeric").text + " " + element.search(".day-month").text
#   puts element.search(".event-text").text.gsub(/\s+/, " ").strip
#   puts "------------------------------------------"
# end
