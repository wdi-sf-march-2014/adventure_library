require 'spec_helper'

describe '/adventures' do
  before(:each) do 
    @local_adventure = Adventure.create!(:title => "test",
                                        :author => "Test author")
    @local_adventure.pages.create!(:name => "start", :text => "cool story bro")

    @foreign_adventure = Adventure.create!(:title => "Ceci n'est pas un test.",
                                    :author => "Foreign author",
                                    :library_id => 4)
    @foreign_adventure.pages.create(:name => "start", :text => "Chouette histoire, mec.")
  end
	describe 'GET with JSON' do
    before(:each) do 
      get '/adventures.json'
    end
    it 'returns a list of all the adventures made locally' do
      result = JSON.parse(response.body)
      result["adventures"].should_not == nil
      result["adventures"].length.should == 1
      result["adventures"].first["title"].should == @local_adventure["title"]
    end

    it 'does not return adventures made on another server' do 
      result["adventures"].detect{|a| a["title"] == @foreign_adventure.title
        }.should == nil
    end
  end

  # describe 'GET with HTML' do
  #   before do
  #     get '/adventures'
  #   end
  #   it 'returns all adventures'
  #   it 'returns adventures made on another server'    
  # end

  # describe 'POST' do
  #   it 'adds a locally made adventure'
  # end
end

describe '/libraries' do
    describe 'GET with JSON' do
      it 'returns a list of known libraries'
    end
end