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
    p date1 = element.search("li:nth-child(3)").text #date de début si date de début
    p date2 = element.search("li:nth-child(4)").text #headline #date de début si date de début
    p date_test = "7 april 2017"
    p Time.parse(date_test)
    p date3 = element.search("li:nth-child(5)").text #headline #date de fin si date de fin
    event = Event.new(
      occurs_at: date2,
      headline_initial: title,
      headline: title,
      sub_category: SubCategory.find_by(name: 'Beaux-arts'),
      status: "Pending"
      )
    p event
    p event.save!
    end
  end


  # def date_translater_expositions(french_date)
  #    array = french_date.split(/\W+/)
  #    array.delete_at(0)
  #    translation = {
  #     janvier: 'January',
  #     fevrier: 'February',
  #     mars: 'March',
  #     avril: 'April',
  #     mai: 'May',
  #     juin: "June",
  #     juillet: 'July',
  #     aout: 'August',
  #     septembre: 'September',
  #     octobre: 'October',
  #     novembre: 'November',
  #     decembre: 'December'
  #   }
  #     new_date = [array[0], translation[array[1].to_sym], array[2]].join(' ')


  # end
end
