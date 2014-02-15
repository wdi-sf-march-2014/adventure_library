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
end