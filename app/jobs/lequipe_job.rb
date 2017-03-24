require 'open-uri'
require 'nokogiri'



class LequipeJob < ApplicationJob
  queue_as :default

  def perform
    puts "yeah it works"
    html_file = open("http://www.lequipe.fr/Football/FootballResultat54952.html")
    lequipe_ligue1(html_file)

    # Do something later
  end

  def lequipe_ligue1(html_file)
    categorie = Category.find_by_name('Culture')
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('.bb-color').each do |element|


    p element.xpath('preceding-sibling::h2').last.text

    p title = [element.search('.equipeDom').text, element.search('.equipeExt').text, element.search('.score').text].join(" - ")

    # event = Event.new(
    #         headline: element.search('.meta-title-link').text,
    #         category: categorie,
    #         sub_category_id: '22',
    #         description: seances_num,
    #         occurs_at: date_translater(element.search('.date').text)
    #         )
    p event


    end
  end
end
