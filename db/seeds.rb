# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

name = "RuffinRandy"
adv = Adventure.create!(:title => "#{name}'s Test Adventure",
	:author => name)
adv.pages.create!(:name => "start",
	:text => "This is a great text adventure which is beginning right now!  I can't wait to [[stink it up|stink]] [[go to jail|clink]] [[see the end|end]]")
adv.pages.create!(:name => "stink",
	:text => "this story stinks")
adv.pages.create!(:name => "clink",
	:text => "you go to jail [[break out|escape]]")
adv.pages.create!(:name => "end", 
	:text => "Wow that adventure was amazing!")
adv.pages.create!(:name => "escape",
	:text => "you escaped [[see the end|end]]")


