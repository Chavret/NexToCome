require 'csv'

csv_options = { col_sep: ';', quote_char: '"', headers: :first_row }
filepath    = File.join(__dir__, 'ComingUpDataCSV2.csv')

CSV.foreach(filepath, csv_options) do |row|
  puts "#{row[0]}: #{row[1]}, Sous-catégorie #{row[8]} (n°: #{row[3]}). Rating: #{row[4]}. Source:#{row[5]}"
end
