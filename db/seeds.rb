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

n = 0

20.times  do
  date = rand(1..14).days.from_now.to_date
  rating = rand(0..5)
  sub_category = SubCategory.all.sample
  headline = "Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah"
  n += 1

  Event.create!({
    occurs_at:         date,
    headline:          headline + n.to_s,
    headline_initial:  headline + n.to_s,
    sub_category:      sub_category,
    rating:            rating,
    source:            "www.blah.com"
  })
end

puts "Seed OKAYYY"
