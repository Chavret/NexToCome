
require 'open-uri'
require 'nokogiri'


class AllocineJob < ApplicationJob
  queue_as :default

  def perform
    # Do something later

    t = Time.now
    4.times do
    t += 7*24*60*60
    scraped_week = t.strftime("sem-%Y-%m-%d/")
    html_file = open("http://www.allocine.fr/film/agenda/#{scraped_week}")
    allocine_week_scraper(html_file)
  end

  end


  def allocine_week_scraper(html_file)
    categorie = Category.find_by_name('Economie')
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('.card-entity-list').each do |element|
      seances = element.search('.txt').text
      if seances.include? '('
        seances_num = seances.scan(/\(([^\)]+)\)/).last.first.to_i
          if  seances_num > 200

          # and Event.where(name: element.search('.meta-title-link').text).blank?
          event = Event.new(
            headline: element.search('.meta-title-link').text,
            category: categorie,
            sub_category_id: '22',
            description: seances_num,
            occurs_at: '22 avril 2017'
            )
          p element.search('.date').text
          p event.headline
          p event.valid?
          if event.headline == "Les Schtroumpfs et le village perdu"
            binding.pry
          end
          p event.errors.full_messages
          p event.save
          end
      end
    end
end


#faire le scraper pour un mois avec une condition "est ce que ça existe déjà ?"

#apres il suffira dinstaller la gem qui le fait automatiquement




end
