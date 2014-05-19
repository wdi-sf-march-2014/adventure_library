# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

adv1 = Adventure.create!(:title => "Killing Pigeons",
	:author => "Zoe")

Page.create!(:name => "start",
	:text => "pigeons are running rampant in the city, carrying diseases wherever they go. you can [[be part of the solution|control]] or [[let them do their thing|fail]]", adventure: adv1)

Page.create!(:name => "fail",
	:text => "you're just going to let them take over?! well, you've made your bed. and it has pigeons in it.", adventure: adv1)

Page.create!(:name => "control",
	:text => "glad to have you aboard. do you want to [[set up traps|trap]], [[install scarecrow-like bird statues around town|scare]], or [[start prescribing pigeon birth control|deplete]]", adventure: adv1)

Page.create!(:name => "scare",
	:text => "nice effort, but it didn't work.", adventure: adv1)

Page.create!(:name => "trap",
	:text => "great. what are you going to do once you've captured them? [[drive them somewhere else and release them|release]] or [[kill 'em!|kill]]?", adventure: adv1)

Page.create!(:name => "deplete",
	:text => "smart! that's the only real long-term effective way to go. but what can we do in the meantime? [[just wait for the elders to die|wait]]? or [[something more drastic|drastic]]", adventure: adv1)

Page.create!(:name => "release",
	:text => "nice try, but they'll just find their way back. that was a waste of effort.", adventure: adv1)

Page.create!(:name => "kill",
	:text => "sounds like you've got your work cut out for you. keep fighting the good fight!", adventure: adv1)

Page.create!(:name => "wait",
	:text => "okay then. guess we better get used to these pigeons then.", adventure: adv1)

Page.create!(:name => "drastic",
	:text => "we can tell you're really willing to take measures to improve this city. the mayor has awarded you the key to the city for all of your efforts. well done!", adventure: adv1)