# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
name = "Joshua P"

lib = Library.create!(:url => "http://adventures-with-raphael.herokuapp.com/")

adv = Adventure.create!(:title => "#{name}'s Test Adventure", :author => name)
adv.pages.create!(:name => "start", :text => "This is a great text adventure which is beginning right now!  I can't wait to [[see the end|end]]", :adventure_id => 1)
adv.pages.create!(:name => "end", :text => "Wow that adventure was amazing!", :adventure_id => 1)

adv2 = Adventure.create(title: "My First Adventure Test By Form", author: "Joshua P")
adv2.pages.create(name: "start", text: "You find yourself up until 2am working on a WDI project. Do you [[go to sleep|sleep]] or [[stay awake|end]]")
adv2.pages.create(name: "sleep", text: "You fall asleep on you laptop and it breaks. Do you [[take it in to the shop|shop]] or do you use a [[pen and paper|end]]")
adv2.pages.create(name: "shop", text: "You go in the to the mac store and do you [[go up to somebody|end]] or [[wait for somebody to come to you|end]]")
adv2.pages.create(name: "end", text: "You are eaten by bears in the mac store. You're dead")