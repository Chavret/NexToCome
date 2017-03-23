require 'open-uri'
require 'nokogiri'

i = 1

def eventseye_scraper(html_file)
    html_doc = Nokogiri::HTML(html_file)
    html_doc.search('tr').each do |element|
      puts title = element.search("td.mt b").text
      puts info =  element.search("td.mt i").text
      puts date = element.search("td.mtb").text
      puts info =  element.search("td.mt:nth-child(2)").text
      puts info =  element.search("td.mt:nth-child(3) b").text
      puts "-----------------------------------"
      # if date != nil
      #     event = {
      #       occurs_at: date,
      #       headline: "#{title} - #{info}",
      #       sub_category_name: "Entreprises",
      #       }
      # end
    end
end

url2 = "http://www.eventseye.com/fairs/c0_salons_france.html"
html_file = open(url2) #puis +=1 à chaque page
eventseye_scraper(html_file)

19.times do
  url = "http://www.eventseye.com/fairs/c0_salons_france_#{i}.html"
   html_file = open(url) #puis +=1 à chaque page
  eventseye_scraper(html_file)
  i += 1
  end
