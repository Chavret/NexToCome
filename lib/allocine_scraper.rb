require 'open-uri'
require 'nokogiri'

html_file = open("http://www.allocine.fr/film/agenda/")
html_doc = Nokogiri::HTML(html_file)

html_doc.search('.card-entity-list').each do |element|
  puts element.search('.meta-title-link').text
  puts element.search('.date').text
end

#faire le scraper pour un mois avec une condition "est ce que ça existe déjà ?"

#apres il suffira dinstaller la gem qui le fait automatiquement



