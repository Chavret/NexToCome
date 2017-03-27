namespace :expositions do
  desc "TODO"
  task expositions_scraper: :environment do
    ExpositionsJob.perform_later
  end

end
