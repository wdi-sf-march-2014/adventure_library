# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
name = 'daveyk'

adv = Adventure.create!(:title => "#{name}'s Test Adventure",
	:author => name)
adv.pages.create!(:name => "start",
	:text => "This is a great text adventure which is beginning right now!  I can't wait to [[see the end|end]]")
adv.pages.create!(:name => "end",
	:text => "Wow that adventure was amazing!")

adv = Adventure.create!(:title => "#{name}'s Next Adventure",
  :author => name)
adv.pages.create!(:name => "start",
  :text => "My second adventure!  I can't wait to [[what happens next|next]]")
adv.pages.create!(:name => "next",
  :text => "Wow this adventure is amazing! Let's go to [[the end|end]]")
adv.pages.create!(:name => "end",
  :text => "Wow that adventure was amazing!")