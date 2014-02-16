class SchedulerWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence {hourly}
  def perform
    Library.all.each do |l|
      ScraperWorker.perform_async(l.id)
    end
  end
end