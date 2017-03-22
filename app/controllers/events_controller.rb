class EventsController < ApplicationController
  def index
    @selected_categories = params[:categories].presence || Category.pluck(:name)
    @categories = Category.all

    events = policy_scope(Event).
      joins(:category).
      where(categories: { name: @selected_categories }).
      order(created_at: :desc)

    @hash = {}
    date = Time.now.to_date - 1.days
    30.times do
      @hash[date += 1.day] = []
    end

    @hash.each do |date, _date_events|
      @hash[date] << events.where(occurs_at: date)
      @hash[date].flatten!
    end

  end
end
