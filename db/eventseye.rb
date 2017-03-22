require 'open-uri'
require 'nokogiri'


i = 1

html_file = open("http://www.eventseye.com/fairs/c0_salons_france_#{i}.html") #puis +=1 à chaque page
html_doc = Nokogiri::HTML(html_file)

# until i = 19

#   html_file.each do |i|
#   open("http://www.eventseye.com/fairs/c0_salons_france_#{i}.html")

    html_doc.search('tr').each do |element|
      title = element.search("td.mt b").text.gsub(/\s+/, " ")
      info = puts element.search("td.mt i").text.gsub(/\s+/, " ")
      date = element.search("td.mtb").text.gsub(/\s+/, " ")
      if date != nil
          event = {
            occurs_at: date,
            headline: "#{title} - #{info}",
            sub_category_name: "Entreprises",
            }
      end
    end

html_doc.search('tr').each do |element|
  puts element.search("td.mt b").text.gsub(/\s+/, " ")
  puts element.search("td.mt i").text.gsub(/\s+/, " ")
  puts element.search("td.mtb").text.gsub(/\s+/, " ")
  puts "------------------------------------------"
  end

