require 'spec_helper'

describe '/adventures' do
  before(:each) do 
    @local_adventure = Adventure.create!(:title => "test",
      :author => "Test author")
    @local_adventure.pages.create!(:name => "start", :text => "cool story bro")

    @l = Library.create(:url => "example.com")
    @foreign_adventure = Adventure.create!(:title => "Ceci n'est pas un test.",
      :author => "Foreign author",
      :library_id => @l.id)

    @foreign_adventure.pages.create(:name => "start", :text => "Chouette histoire, mec.")

  end
  describe 'GET with JSON' do
    before(:each) do 
      get '/adventures.json'
      @result = JSON.parse(response.body)
    end
    it 'returns a list of all the adventures made locally' do

      @result["adventures"].should_not == nil
      @result["adventures"].length.should == 1
      adv = @result["adventures"].first
      adv["title"].should == @local_adventure.title
      adv["created_at"].should_not == nil
      adv["updated_at"].should_not == nil
      adv["id"].should == nil
      adv["author"].should == @local_adventure.author
    end

    it 'gets back the pages of a returned adventure' do 
      pages = @result["adventures"].first["pages"]
      pages.should_not == nil
      pages.length.should == @local_adventure.pages.length
      p = pages.first
      p_in_db = @local_adventure.pages.first
      p["name"].should == p_in_db.name
      p["text"].should == p_in_db.text
    end

    it 'does not return adventures made on another server' do 
      @result["adventures"].detect{|a| a["title"] == @foreign_adventure.title
        }.should == nil
      end
    end

    describe 'GET with HTML' do
      it 'returns all adventures' do 
        get '/adventures'

        [@local_adventure, @foreign_adventure].each do |a|
          response.body.should include(ERB::Util.html_escape(a.title)) 
        end
      end
      it 'works with a pagesless adventure' do 
        a = Adventure.create!(:title => "Another one.",
          :author => "Pageless",
          :library_id => @l.id)
        get '/adventures'
        response.status.should == 200
        response.body.should include(ERB::Util.html_escape(a.title))
      end
    end
  end

