class Library < ActiveRecord::Base
  has_many :adventures

  def normalize_url u 
    PostRank::URI.normalize(u).to_s
  end
  def url= u 
    super(normalize_url(u))
  end

  def adventures_url
    u = URI(url)
    u.path += "adventures.json"
    u.to_s
  end

  def libraries_url
    u = URI(url)
    u.path += "libraries.json"
    u.to_s
  end

  def scrape_adventures
    adventure_resp = JSON.parse(Typhoeus.get(adventures_url).body)
    adventure_resp["adventures"].each do |a|
      record = adventures.find_or_initialize_by(:guid => a.delete("guid"))
      a["pages_attributes"] = a.delete("pages")
      if !record.persisted? || Time.parse(a["updated_at"]) > record.updated_at
        record.update_attributes(a)
      end 
    end
  end

  def scrape_libraries
    l_resp = JSON.parse(Typhoeus.get(libraries_url).body)
    l_resp["libraries"].each do |l| 
      record = Library.find_or_initialize_by(:url => normalize_url(l["url"]))
      record.save! unless record.persisted?
    end

  end
end