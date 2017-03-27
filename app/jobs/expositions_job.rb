require 'open-uri'
require 'nokogiri'

class ExpositionsJob < ApplicationJob
  queue_as :default

  def perform # Do something later
    html_file = open("http://www.offi.fr/expositions-musees/prochainement.html")
    expositions(html_file)
  end

  def expositions(html_file)
    html_doc = Nokogiri::HTML(html_file)
    html_doc.search('.oneRes').each do |element|
    title = element.search(".eventTitle").text #headline
    type = element.search("li:nth-child(1)").text #sub_category
    info = element.search("li:nth-child(2)").text #description-localisation
    date1 = element.search("li:nth-child(3)").text #date de début si date de début
    date2 = element.search("li:nth-child(4)").text #headline #date de début si date de début
    date3 = element.search("li:nth-child(5)").text #headline #date de fin si date de fin
    event = Event.new(
      occurs_at: date2,
      headline_initial: title,
      sub_category_name: "Beaux-Arts",
      )
  end

end
