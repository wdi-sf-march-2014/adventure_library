# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

name = "Sam"
adv = Adventure.create!(
  :title => "#{name}'s Test Adventure",
	:author => name,
  :GUID => SecureRandom.urlsafe_base64(10)
  )
adv.pages.create!(
  :name => "start",
	text: "This is a great text adventure which is beginning right now!  I can't wait to [[see the end|end]]")
adv.pages.create!(
  :name => "end",
	text: "Wow that adventure was amazing!")

# take a trip to moonside
moonside = Adventure.create!(
  :title => "Take a Trip to Moonside",
  :author => name,
  :GUID => SecureRandom.urlsafe_base64(10)
  )

moonside.pages.create!(
  name: "start",
  text: "Its friday night and you just got back from your job at Pizza City, your back in your crappy apartment with no plans and nothing to do. You turn on the tv and try to unwind. What do you do?\n\n[[drink a beer|beer]]\n[[call up Eric|Eric]]"
)

moonside.pages.create(
  name: "beer",
  text: "Ewwww its all warm and expired! Is this even beer? You read the label and it reads POISON....You've been sabotaged by a stranger!!!! probably that stranger who lives in the other room next to yours!!..You start to fall asleep..."
)

moonside.pages.create(
  name: "Eric",
  text: "You dial up Eric trying to find out whats going on tonight, Eric responds telling you to head downtown to a party. For some reason you dont trust him.. What do you do?\n\n[[go downtown|downtown]]\n[[go play x box|xbox]]"
)

moonside.pages.create(
  name: "downtown",
  text: "Your downtown at the specified address Eric gave you, you receieve a text from Eric telling you to walk down a path leading to a door. Something does not seem right here...What do you do?\n\n[[Run away!!!|runaway]]\n[[open the door|door]]" 
)

moonside.pages.create(
  name: "xbox",
  text: "You start to play Xbox and get into a heated COD match in which you get owned by some 13 year old from craptown USA, F**ck this! You scream out, you head to your bed really tired....Night night"
)

moonside.pages.create(
  name: "door",
  text: "You open the door, the lights are turned off...its silent and dark in here..suddenly you hear a huge BANG!! SURRPISE ITS YOUR BIRTHDAY!..Aww shucks you turn around and get a big birthday pie in the face! CONGRATS YOU SURVIVED MOONSIDE!!"
)

moonside.pages.create(
  name: "runaway",
  text: "You try to run away as fast as you can. Suddenly you trip and hit your head on the pavement...Ouch...YOUR UNCONCIOUS!!!"
)















