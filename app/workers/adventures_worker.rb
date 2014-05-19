class AdventuresWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 1

  def perform(library_id)
    saved_library = Library.find(library_id)
    url = saved_library.url

  	#request all local adventures
    adv_json = Typhoeus.get(url+'/adventures.json')
    adv = JSON.parse(adv_json.body)
    adventures = adv["adventures"]

    #add each adventure and its pages to the DB
    adventures.each do |import|

      #check to make sure that it doesn't yet exist and it has pages
      if (!Adventure.where(guid: import["guid"]).exists?) && (import["pages"] != nil)
        
        title = import["title"]
        author = import["author"]
        guid = import["guid"]
        saved_adventure = saved_library.adventures.create(title: title, author: author, guid: guid)

        import["pages"].each do |page_import|
          name = page_import["name"]
          text = page_import["text"]
          saved_page = saved_adventure.pages.create(name: name, text: text)
        end
      end
    end
  end
end

#if integrating sidetiq, add check on if it exists and if so, compare timestamps




    

