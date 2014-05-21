 module LibrariesHelper

  def scrape(url)
     adventures = Typhoeus.get("#{url}/adventures.json")
     @outside_adventures = JSON.parse(adventures.body)["adventures"]
 
     libraries = Typhoeus.get("#{url}/libraries.json")
     @outside_libraries = JSON.parse(libraries.body)["libraries"]
   end
 
   def url_cleanup(cleanup_url)
     uri = URI.parse(cleanup_url)
     cleanup_url.downcase!
     cleanup_url = ("http://" + cleanup_url) unless uri.scheme
     cleanup_url = cleanup_url.split("/").slice(0,3).join("/")
 
   end
  end