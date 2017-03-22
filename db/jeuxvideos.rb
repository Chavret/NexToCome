require 'open-uri'
require 'nokogiri'

html_file5 = open("https://www.senscritique.com/jeuxvideo/prochaines-sorties")
html_doc5 = Nokogiri::HTML(html_file5)

html_doc5.search('.elpr-content').each do |element|
  title = element.search(".elco-anchor").text.gsub(/\s+/, " ").strip
  date = element.search("time").text.gsub(/\s+/, " ").strip
  topo = element.search(".elco-description").text.gsub(/\s+/, " ").strip
  if date != nil
    event = {
      occurs_at: date,
      headline: title,
      sub_category_name: "Jeux vidéos",
      }
  end
end

html_doc5.search('.elpr-content').each do |element|
    title = element.search(".elco-anchor").text.gsub(/\s+/, " ").strip
    date = element.search("time").text.gsub(/\s+/, " ").strip
    topo = element.search(".elco-description").text.gsub(/\s+/, " ").strip
    if date != nil
      puts title
      puts date
      puts topo
      puts "------------------------------------------"
    end
  end

