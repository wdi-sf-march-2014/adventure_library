class LibrariesWorker
  include Sidekiq::Worker

  def perform(url)
    if url.end_with?("json")
      response = Typhoeus.get(url)
    else
      response = Typhoeus.get(url + "/libraries.json")
    end
    JSON.parse(response.body)["libraries"].each do |library|
      if Typhoeus.get(library["url"] + "libraries.json").response_code == 200 && Library.where(["url = ?", library["url"]]).empty? == true && library["url"].include?("heroku") == true
        lib = Library.new(library)
        if lib.save
          AdventuresWorker.perform_async(lib.id)
        end     
      end
    end
  end
end