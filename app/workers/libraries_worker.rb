class LibrariesWorker
  include Sidekiq::Worker
  require 'sidekiq'

  def perform(url)
  end

end