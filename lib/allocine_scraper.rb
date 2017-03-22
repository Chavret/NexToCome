  require 'open-uri'
  require 'nokogiri'


  t = Time.now
  #get an array of the next 4 weeks in the allocine format

  def allocine_week_scraper(html_file)

    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('.card-entity-list').each do |element|
      seances = element.search('.txt').text
      if seances.include? '('
        seances_num = seances.scan(/\(([^\)]+)\)/).last.first.to_i
          if  seances_num > 200
            # and Event.where(name: element.search('.meta-title-link').text).blank?
          event = {
            headline: element.search('.meta-title-link').text,
            occurs_at: element.search('.date').text,
            sub_category_id: '22',
            description: seances_num
            }
          puts event
          end
      end
    end
end

  4.times do
    t += 7*24*60*60
    scraped_week = t.strftime("sem-%Y-%m-%d/")
    html_file = open("http://www.allocine.fr/film/agenda/#{scraped_week}")
    allocine_week_scraper(html_file)
  end
#faire le scraper pour un mois avec une condition "est ce que ça existe déjà ?"

#apres il suffira dinstaller la gem qui le fait automatiquement



