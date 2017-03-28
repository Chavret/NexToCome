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
    beg = element.search("li:nth-child(3)").text
    beg2 = element.search("li:nth-child(4)").text
    if beg.include? "début"
      date = element.search("li:nth-child(3)").text
    elsif beg2.include? "début" #date de début si date de début
      date = element.search("li:nth-child(4)").text
    end
    p date = date[16..-1]
    p date_translater_expositions(date)
    event = Event.new(
      occurs_at: date_translater_expositions(date),
      headline_initial: title,
      headline: title,
      sub_category: SubCategory.find_by(name: 'Beaux-arts'),
      status: "Pending"
      )
    p event
    p event.save!
    end
  end


   def date_translater_expositions(french_date)
      array = french_date.split(/\W+/)
      translation = {
       janvier: 'January',
       fevrier: 'February',
       mars: 'March',
       avril: 'April',
       mai: 'May',
       juin: "June",
       juillet: 'July',
       aout: 'August',
       septembre: 'September',
       octobre: 'October',
       novembre: 'November',
       decembre: 'December'
     }
       date = [array[0], translation[array[1].to_sym], array[2]].join(' ')


  end
end
