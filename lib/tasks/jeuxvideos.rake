namespace :jeuxvideos do
  desc "TODO"
  task jeuxvideos_scraper: :environment do
    JeuxvideosJob.perform_later
  end

end
