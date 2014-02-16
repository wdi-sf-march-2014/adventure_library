require 'spec_helper'

describe Library do
  let (:l) { Library.create!(:url => "my-library.example.com")}

  describe 'url' do 
    it 'normalizes' do
      lib = Library.new(:url => "my-library.com")
      lib.url.should == "http://my-library.com/"
    end
  end
  def json_response d
    Typhoeus::Response.new(:code => 200, :body => d.to_json)
  end
  describe '#scrape_adventures' do
    let (:adv_empty) { json_response({"adventures" => []}) }
    let (:adv_data) { {"adventures" => [{"title" => "Raphael Sofaer's Test Adventure","author" => "Raphael Sofaer","created_at" => "2014-02-15T22:13:10.866Z","updated_at" => "2014-02-15T22:39:01.606Z","guid" => "h5iM2Fs8QS6lWA","pages" => [{"name" => "start","text" => "This is a great text adventure which is beginning right now!  I can't wait to [[see the end|end]]"},{"name" => "end","text" => "Wow that adventure was amazing!"}]}]}}

    let (:adv_resp) { json_response(adv_data)}
    it 'makes a request to url/adventures.json' do
      Typhoeus.should_receive(:get).with(l.adventures_url).and_return(adv_empty)
      l.scrape_adventures
    end
    it 'saves a new adventure' do
      Typhoeus.stub(l.adventures_url).and_return(adv_resp)
      l.scrape_adventures
      a = Adventure.find_by(:title => "Raphael Sofaer's Test Adventure")
      a.should_not be_nil
      a.pages.length.should == 2
      a.pages.find_by(:name => "start").should_not be_nil
    end

    it 'updates when recieving an updated adventure' do
      ad = adv_data["adventures"][0].deep_dup
      ad["pages_attributes"] = ad.delete("pages")

      a = l.adventures.create!(ad)

      t = Time.now
      adv_data["adventures"][0]["updated_at"] = t.to_json
      adv_data["adventures"][0]["title"] = "new title"

      Typhoeus.stub(l.adventures_url).and_return(adv_resp)
      l.scrape_adventures

      a.reload
      a.title.should == "new title"
    end
    it 'does not update unless the adventure is more recent' do
            ad = adv_data["adventures"][0].deep_dup
      ad["pages_attributes"] = ad.delete("pages")

      a = l.adventures.create!(ad)
      adv_data["adventures"][0]["title"] = "new title"

      Typhoeus.stub(l.adventures_url).and_return(adv_resp)
      l.scrape_adventures

      a.reload
      a.title.should_not == "new title"

    end

    describe '#scrape_libraries' do 
      let(:lib_empty) {json_response({"libraries" => []})}
      let(:libs) {json_response({"libraries" => [{"url" => "library.example.com"}]})}
      it 'scrapes libraries' do
        Typhoeus.should_receive(:get).with(l.libraries_url).and_return(lib_empty)
        l.scrape_libraries
      end
      it 'saves received new libraries' do 
        Typhoeus.stub(l.libraries_url).and_return(libs)

        l_count = Library.count
        l.scrape_libraries
        Library.count.should == l_count + 1
      end
      it 'does not save repeat libraries' do 
        Typhoeus.stub(l.libraries_url).and_return(libs)

        Library.create!({"url" => "library.example.com"})
        l_count = Library.count
        l.scrape_libraries
        Library.count.should == l_count
      end
    end

  end
end