# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

# Adapted from: https://leonid.shevtsov.me/post/need-random-sample-images-why-not-imgur/
# Note we have to change ['galler'] to ['data']
gallery = JSON.parse(open('http://imgur.com/gallery.json').read)['data']

# construct URLs
gallery.each {|i| i['url'] = "http://imgur.com/#{i['hash']}#{i['ext']}" }

gallery.each do |image|
  Photo.create(
    username: Faker::Internet.user_name,
    caption: Faker::Lorem.sentence,
    likes_count: Faker::Number.number(4),
    url: image['url'],
    created_at: Faker::Time.between(1.year.ago, Time.now)
  )
end

# update all photos with missing images
Photo.where(url: nil).each do |photo|
  photo.update_column :url, "https://unsplash.it/500"
end

Photo.all.each do |photo|
  rand(5).times do
    photo.comments.create! username: Faker::Internet.user_name, body: Faker::Hipster.sentence
  end
end