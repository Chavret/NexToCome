
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# testing = SubCategory.create!(name: "test")

# csv_options = { col_sep: ';', headers: :first_row }
# filepath    = File.join(__dir__, 'CSVfileSimon.csv')

# CSV.foreach(filepath, csv_options) do |row|
#   event = Event.create!(headline: row[1], occurs_at: Date.parse(row[0]), sub_category: testing)
#   puts event.headline
# end




Event.destroy_all
SubCategory.destroy_all
Category.destroy_all

culture = Category.create!(name: "Culture")

beaux_arts = SubCategory.create!(name: "Beaux-arts", category_id: culture.id)
cinéma = SubCategory.create!(name: "Cinéma", category_id: culture.id)
gastronomie = SubCategory.create!(name: "Gastronomie", category_id: culture.id)
humour = SubCategory.create!(name: "Humour", category_id: culture.id)
jeux_videos = SubCategory.create!(name: "Jeux vidéos", category_id: culture.id)
litterature = SubCategory.create!(name: "Littérature", category_id: culture.id)
musique = SubCategory.create!(name: "Musique", category_id: culture.id)
opéra = SubCategory.create!(name: "Opéra", category_id: culture.id)
télévision = SubCategory.create!(name: "Télévision", category_id: culture.id)
théâtre = SubCategory.create!(name: "Théâtre", category_id: culture.id)


economie = Category.create!(name: "Economie")

consommation = SubCategory.create!(name: "Consommation", category_id: economie.id)
entreprises = SubCategory.create!(name: "Entreprises", category_id: economie.id)
finances = SubCategory.create!(name: "Finances", category_id: economie.id)
high_tech = SubCategory.create!(name: "High-tech", category_id: economie.id)
immobillier = SubCategory.create!(name: "Immobillier", category_id: economie.id)
macroéconomie = SubCategory.create!(name: "Macroéconomie", category_id: economie.id)
medias = SubCategory.create!(name: "Medias", category_id: economie.id)
sciences = SubCategory.create!(name: "Sciences", category_id: economie.id)
tourisme = SubCategory.create!(name: "Tourisme", category_id: economie.id)
transport = SubCategory.create!(name: "Transport", category_id: economie.id)


societé = Category.create!(name: "Societé")

diversite = SubCategory.create!(name: "Diversité", category_id: societé.id)
elections = SubCategory.create!(name: "Elections", category_id: societé.id)
environnement = SubCategory.create!(name: "Environnement", category_id: societé.id)
histoire = SubCategory.create!(name: "Histoire", category_id: societé.id)
international = SubCategory.create!(name: "International", category_id: societé.id)
justice = SubCategory.create!(name: "Justice", category_id: societé.id)
lifestyle = SubCategory.create!(name: "Lifestyle", category_id: societé.id)
politique = SubCategory.create!(name: "Politique", category_id: societé.id)
santé = SubCategory.create!(name: "Santé", category_id: societé.id)
servicespublics = SubCategory.create!(name: "Services publics", category_id: societé.id)


sport = Category.create!(name: "Sport")

athletisme = SubCategory.create!(name: "Athlétisme", category_id: sport.id)
automoto = SubCategory.create!(name: "Auto-moto", category_id: sport.id)
basket = SubCategory.create!(name: "Basket", category_id: sport.id)
cyclisme = SubCategory.create!(name: "Cyclisme", category_id: sport.id)
football = SubCategory.create!(name: "Football", category_id: sport.id)
hippisme = SubCategory.create!(name: "Hippisme", category_id: sport.id)
rugby = SubCategory.create!(name: "Rugby", category_id: sport.id)
sportsdecombat = SubCategory.create!(name: "Sports de combat", category_id: sport.id)
tennis = SubCategory.create!(name: "Tennis", category_id: sport.id)
voile = SubCategory.create!(name: "Voile", category_id: sport.id)

viepratique = Category.create!(name: "Vie pratique")

joursferies = SubCategory.create!(name: "Jours fériés", category_id: viepratique.id)
météo = SubCategory.create!(name: "Météo", category_id: viepratique.id)
saints = SubCategory.create!(name: "Saints", category_id: viepratique.id)
vacances = SubCategory.create!(name: "Vacances", category_id: viepratique.id)
fetesetrangeres = SubCategory.create!(name: "Fêtes étrangères", category_id: viepratique.id)
jours_speciaux = SubCategory.create!(name: "Jours spéciaux", category_id: viepratique.id)


require 'csv'

csv_options = { col_sep: ';', quote_char: '"', headers: :first_row }
filepath    = File.join(__dir__, '170327Database.csv')

CSV.foreach(filepath, csv_options) do |row|
  if SubCategory.exists?(name: row[8])
    event = Event.create!(occurs_at: Date.parse(row[0]), headline: row[1], headline_initial: row[2], rating: row[4], source: row[5], description: row[7])
    sub_cat = SubCategory.where(name: row[8].to_s).first
    event.sub_category = sub_cat
    event.status = "Valid"
    event.save
  else
    event = Event.create!(occurs_at: Date.parse(row[0]), headline: row[1], headline_initial: row[2], rating: row[4], source: row[5], status: "Pending", description: row[7])
  end
end

puts "Seed OKAYYY"

