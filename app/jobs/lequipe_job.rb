require 'open-uri'
require 'nokogiri'



class LequipeJob < ApplicationJob
  queue_as :default

  def perform
    html_file = open("http://www.lequipe.fr/Football/FootballResultat54952.html")
    classement = open("http://www.lequipe.fr/Football/ligue-1-classement.html")
    top_teams = top_selection(classement)
    lequipe_ligue1(html_file, top_teams)

    # Do something later
  end

  def lequipe_ligue1(html_file, top_teams)
    categorie = Category.find_by_name('Sport')
    html_doc = Nokogiri::HTML(html_file)

    html_doc.search('.bb-color').each do |element|
    title = [element.search('.equipeDom').text, element.search('.equipeExt').text, element.search('.score').text].join(" - ")

    if top_teams & title.split != []
    #create event only if included in top selection: it's still never validating

      event = Event.new(
              headline: title,
              headline_initial: title,
              category: categorie,
              sub_category_id: SubCategory.find_by(name: 'Football'),
              occurs_at: date_translater_lequipe(element.xpath('preceding-sibling::h2').last.text
              ))
      p event.headline
    end

    end
  end

  def top_selection(html_file)
    top_to_take = "5"
    top_teams = []
    html_doc = Nokogiri::HTML(html_file)
    html_doc.search('.js-tr-hover').each do |team|
    p team.search('.team-label').text
    top_teams << team.search('.team-label').text
    break if team.search('.rang').text == top_to_take
   end
   top_teams
  end

  def date_translater_lequipe(french_date)
     array = french_date.split(/\W+/)
     array.delete_at(0)
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
      new_date = [array[0], translation[array[1].to_sym], array[2]].join(' ')


  end
end


Event.all
