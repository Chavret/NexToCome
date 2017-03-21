# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# .strftime("%d/%m/%Y")
Event.destroy_all
SubCategory.destroy_all
Category.destroy_all

Category.create!({ name: "Culture" })
Category.create!({ name: "Sport" })
Category.create!({ name: "Economie" })
Category.create!({ name: "Societe" })
Category.create!({ name: "Vie Pratique" })

n = 0

10.times do
  n += 1
  SubCategory.create!({
    name: "Culture #{n}",
    category: Category.where(name: "Culture").first
  })
   SubCategory.create!({
    name: "Sport #{n}",
    category: Category.where(name: "Sport").first
  })
 SubCategory.create!({
    name: "Economie #{n}",
    category: Category.where(name: "Economie").first
  })
 SubCategory.create!({
    name: "Societe #{n}",
    category: Category.where(name: "Societe").first
  })
 SubCategory.create!({
    name: "Vie Pratique #{n}",
    category: Category.where(name: "Vie Pratique").first
  })
end


20.times  do
  date = rand(1..14).days.from_now
  rating = rand(0..5)
  sub_category = SubCategory.all.sample

  Event.create!({
    occurs_at:         date,
    headline:          "Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah",
    headline_initial:  "Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah",
    sub_category:      sub_category,
    rating:            rating,
    source:            "www.blah.com"
  })
end

puts "Seed OKAYYY"
