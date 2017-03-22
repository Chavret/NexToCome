require 'open-uri'
require 'nokogiri'

html_file = open("http://www.electionguide.org/elections/upcoming/")
html_doc = Nokogiri::HTML(html_file)
html_doc.search('tr').each do |element|
  puts element.children[5].text + " in " + element.children[3].text #headline
  puts element.children[7].text #occurs_at
  puts element.children[9].text # only "confirmed" should be selected
  puts "------------------------------------------"
end

