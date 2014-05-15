# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

adv = Adventure.create!(:title => "Mad Hacker",
	:author => "Rahul")
adv.pages.create!(:name => "start",
	:text => "This is the story of Don Draper and his promiscuous ways")
adv.pages.create!(:name => "end",
	:text => "Do you want him to write a new app from scratch or use open source code? ")

adv2 = Adventure.create!(:title => "Breaking Code",
  :author => "Rahul")
adv.pages.create!(:name => "start",
  :text => "This is the story of the man with cancer who hacks websites to support his family")
adv.pages.create!(:name => "end",
  :text => "He brograms with Jesse Pinkman")