namespace :eventseye do
  desc "TODO"
  task eventseye_scraper: :environment do
    EventseyeJob.perform_later
  end

end
