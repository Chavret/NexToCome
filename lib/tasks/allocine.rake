namespace :allocine do
  desc "Scraping 4 weeks of allocine"
  task :scrape_allocine => :environment do
    AllocineJob.perform_later
    # rake task will return when job is _done_
  end
end
