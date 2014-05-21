# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
name = "JaSON"
adv = Adventure.create!(:title => "#{name}'s Test Adventure",
	:author => name)
adv.pages.create!(:name => "start",
	:text => "This is a great text adventure which is beginning right now!  I can't wait to [[see the end|end]]")
adv.pages.create!(:name => "end",
	:text => "Wow that adventure was amazing!")

adv2 = Adventure.create!(:title => "Attack of the Blorgons!", 
  :author => "Abed", 
  :guid => SecureRandom.urlsafe_base64(10).to_s)
adv2.pages.create!(:name => "start",
  :text => "You are Inspector Spacetime, defender of space and time. You are sitting in the command
  center, when suddenly you detect a Blorgon invasion! What do you do? [[Alert the fleet!|alert]] 
    or [[panic!|panic]]")
adv2.pages.create!(:name => "alert",
  :text => "You press the communications button, but you realized your being jammed! What will you do?
  [[Fight|fight]] or [[Flight|flight]]")
adv2.pages.create!(:name => "panic",
  :text => "You ran around the command center a couple time and completely flipped out.
  Ok, now focus man! Time to [[alert the fleet!|alert]]")
adv2.pages.create!(:name => "fight",
  :text => "You decide to try and fight the entire Blorgon fleet by yourself.
  You get blown away within two seconds. [[Try again|start]]")
adv2.pages.create!(:name => "flight",
  :text => "You decide to try and retreat and warn the fleet. But do you manage
  to get away?! Find out next time...")



