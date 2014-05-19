# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

name = 'Blair'

adv = Adventure.create!(:title => "#{name}'s First Adventure",:author => name)
adv.pages.create!(:name => "start",:text => "This is a great text adventure which is beginning right now!  I can't wait to [[see the end|end]]")
adv.pages.create!(:name => "end",:text => "Wow that adventure was amazing!")

adv = Adventure.create!(:title => "#{name}'s Second Adventure", :author => name)
adv.pages.create!(:name => "start",:text => "I totally ready to [[start this adventure|end]]")
adv.pages.create!(:name => "end",:text => "Wow that adventure was amazing!")

adv = Adventure.create!(:title => "#{name}'s Third Adventure", :author => name)
adv.pages.create!(:name => "start",:text => "I want to jumprope thorugh to[[the|end]]")
adv.pages.create!(:name => "end",:text => "Wow that adventure was amazing!")