namespace :presidence do
  desc "TODO"
  task presidence_scraper: :environment do
    PresidenceJob.perform_later
  end

end
