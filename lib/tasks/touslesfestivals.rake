namespace :touslesfestivals do
  desc "TODO"
  task touslesfestivals_scraper: :environment do
    TouslesfestivalsJob.perform_later
  end

end
