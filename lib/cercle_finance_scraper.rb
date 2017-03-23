require 'open-uri'
require 'nokogiri'

html_file = open("http://www.cerclefinance.com/default.asp?pub=calendrier")


html_doc = Nokogiri::HTML(html_file)




html_doc.search('.content').each do |element|
  if element.text.include? 'France'
      event_date1 = element.parent.search('h3').text
      event_date = event_date1.slice(0..(event_date1.index('7')))
      element.search('table').each do |table|
        event_name = ""
        event = {}
        table.search('td').each do |td|
          event_name << " - " + td.text
        end
      event_name.delete!("\r\n")
      event = {
        date: event_date,
        name: event_name,
        category: "macroeconomics",
      }
      p event
      break if table.next_element.name == "div"

        # table.search('td')[1].text
        # table.search('td')[2].text
      end
    # #date
    #description
  end
end

