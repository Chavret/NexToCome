namespace :elections do
  desc "TODO"
  task elections_scraper: :environment do
    ElectionsJob.perform_later
  end

end
