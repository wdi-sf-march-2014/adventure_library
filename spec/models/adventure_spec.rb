require 'spec_helper'

describe Adventure do
  it "should have a guid" do
  	adventure = Adventure.create(title: "title", author: "author", guid: "1234567890")
  	adventure.should be_valid
  end
end
