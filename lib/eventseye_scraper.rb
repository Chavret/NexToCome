require 'open-uri'
require 'csv'
require 'nokogiri'
require 'pry'

def eventseye_scraper(html_file)
  events =[]
  html_doc = Nokogiri::HTML(html_file)
  html_doc.search('tr').each do |element|
    title = element.search("td.mt b").text.gsub(/\s+/, " ")
    info =  element.search("td.mt i").text.gsub(/\s+/, " ")
    date = element.search("td.mtb").text.split(/\b/)
    new_date = "#{date[0]}/#{date[2]}/#{date[8]}" if (date[0].to_i < 31 && date[0].to_i > 0 && date[8].to_i == 2017)
    ville = element.search("td.mt:nth-child(3) b").text.gsub(/\s+/, " ")
    recurence =  element.search("td.mt:nth-child(2)").text.gsub(/\s+/, " ")
    unless (new_date.nil?  || info == "" || ville == "")
      event = {
        occurs_at: Date.parse(new_date).strftime("%d %m %Y"),
        headline_initial: "#{title} -- #{info}",
        sub_category_name: "Entreprises",
        }
      events << event
    end
  end
  return events
end

scrapped_events = []

  url2 = "http://www.eventseye.com/fairs/c0_salons_france.html"
  html_file = open(url2) #puis +=1 à chaque page
  scrapped_events << eventseye_scraper(html_file)

  i = 1

  19.times do
    url = "http://www.eventseye.com/fairs/c0_salons_france_#{i}.html"
    html_file = open(url) #puis +=1 à chaque page
    scrapped_events << eventseye_scraper(html_file)
    i += 1
   end

  filepath = File.join(__dir__, 'eventseye.csv')
  CSV.open(filepath, 'wb') do |csv|
    csv << ['occurs_at','headline_initial','sub_category_name']
    scrapped_events.flatten.each do |event|
      csv << [event[:occurs_at].to_s, event[:headline_initial], event[:sub_category_name]]
    end
  end
