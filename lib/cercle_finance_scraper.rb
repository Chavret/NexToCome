require 'open-uri'
require 'nokogiri'

html_file = open("http://www.cerclefinance.com/default.asp?pub=calendrier")


html_doc = Nokogiri::HTML(html_file)




html_doc.search('.content').each do |element|
  if element.text.include? 'France'
      event_date = element.parent.text
      element.search('table').each do |table|
        event_name = ""
        event = {}
        table.search('td').each do |td|
          event_name << " - " + td.text
        end
      event_name.delete!("\r\n")
      p event_name
      p event_date
      break if table.next_element.name == "div"

        # table.search('td')[1].text
        # table.search('td')[2].text
      end
    # #date
    #description
  end
end

