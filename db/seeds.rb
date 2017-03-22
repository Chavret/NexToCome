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

require 'csv'

csv_options = { col_sep: ';', quote_char: '"', headers: :first_row }
filepath    = File.join(__dir__, 'ComingUpDataCSV.csv')

CSV.foreach(filepath, csv_options) do |row|
  event = Event.create!(occurs_at: Date.parse(row[0]), headline: row[1], headline_initial: row[2], sub_category_id: row[3], rating: row[4], source: row[5], valid: row[6], description: row[7])

end

