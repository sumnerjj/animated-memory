# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

User.create!(email: "example@example.com",
		     password: "password")

5.times do |n|
	User.create!(email: Faker::Internet.email,
		     password: "password")
end

8.times do |n|
	User.find( rand(1..5) ).posts.create!( title: Faker::Lorem.word,
		     body: Faker::Lorem.paragraph(15))
	User.find( rand(1..5) ).articles.create!( title: Faker::Lorem.word,
		     body: Faker::Lorem.paragraph(15))
end

Post.all.each do |p|
	rand(0..8).times do |n|
		User.find( rand(1..5) ).comments.create!(post_id: p.id,
						 body: Faker::Lorem.sentence)
	end
end

Article.all.each do |a|
	rand(0..8).times do |n|
		User.find( rand(1..5) ).comments.create!(article_id: a.id,
						 body: Faker::Lorem.sentence)
	end
end

