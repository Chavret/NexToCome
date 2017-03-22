class EventsController < ApplicationController
  def index
    @categories = Category.all
    @events = policy_scope(Event).order(created_at: :desc)

    @hash = {}
    date = Time.now.to_date - 1.days
    30.times do
      @hash[date += 1.day] = []
    end

    @hash.each do |date, events|
      @hash[date] << Event.where(occurs_at: date)
      @hash[date].flatten!
    end

  end
end
