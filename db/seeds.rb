# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Library.create(:url => "localhost:3000")

name = "Don Drapers"
adv = Adventure.create!(:title => "#{name}'s Test Adventure", :author => name, :guid => SecureRandom.urlsafe_base64(10))
adv.pages.create!(:name => "start", :text => "This is a great text adventure which is beginning right now!  I can't wait to [[see Don Draper die!!!!|end]] or [[live!!!!|end2]]")
adv.pages.create!(:name => "end", :text => "The show is over!")
adv.pages.create!(:name => "end2", :text => "The show must go on!")

adv2 = Adventure.create!(:title => "#Walter Whites's Coding Adventure",
:author => name, :guid => SecureRandom.urlsafe_base64(10))
adv2.pages.create!(:name => "start", :text => "This is a great text adventure which is beginning right now!  I can't wait to [[see Heizenberg hack a hack!!!!|end]] or [[hackathon!!!!|end3]]")
adv2.pages.create!(:name => "end4", :text => "The show is over!")
adv2.pages.create!(:name => "end5", :text => "The show must go on!")
