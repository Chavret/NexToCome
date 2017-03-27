namespace :lequipe do
  desc "TODO"
  task lequipe_scraper: :environment do
    LequipeJob.perform_later
  end

end
