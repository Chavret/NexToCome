namespace :meteo do
  desc "Scraping next meteo"
  task :scrape_meteo => :environment do
    MeteoJob.perform_later
    # rake task will return when job is _done_
  end
end
