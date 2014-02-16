require 'spec_helper'

describe '/libraries' do
  before do
    @library = Library.create!(:url => "example.com")
  end
  describe 'GET with JSON' do
    it 'returns a list of known libraries' do
     get '/libraries.json'
     result = JSON.parse(response.body)
     result["libraries"].first["url"].should == @library.url
   end
 end
 describe 'GET with html' do
  it 'shows a list of libraries' do
    get 'libraries'
    response.body.should include("example.com")
  end
end

describe 'create' do
  it 'creates a library' do
    expect{ 
      post '/libraries', :library => {:url => "my.example.com"}
      }.to change{Library.count}.by(1)
    end
    it 'enqueues a scrape job' do
      ScraperWorker.should_receive(:perform_async)
      post '/libraries', :library => {:url => "example.com"}
    end
    context 'with a library already created' do 
      before(:each) do
        Library.create(:url => "example.com")
      end

      it 'creates no library' do
        expect{ 
          post '/libraries', :library => {:url => "example.com"}
          }.to change{Library.count}.by(0)

        end
        it 'enqueues a job' do
          ScraperWorker.should_receive(:perform_async)
          post '/libraries', :library => {:url => "example.com"}
        end
      end
    end
  end