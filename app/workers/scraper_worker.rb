class ScraperWorker
  include Sidekiq::Worker

  def perform(library_id)
    Library.find_by(:id => library_id).scrape
  end
end