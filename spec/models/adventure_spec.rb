require 'spec_helper'

  describe Adventure do

    it 'should create a new instance of Adventure if given valid attributes' do
      Adventure = Adventure.create(title: "title", author: "author", guid: "1234567899")
      Adventure.should be_valid
    end
  end


