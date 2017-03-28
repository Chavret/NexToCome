class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :destroy, :update]
  skip_after_action :verify_authorized, only: [:admin, :sync_calendar, :show]
  skip_before_action :authenticate_user!, only: [:sync_calendar, :show]


  def new_for_user
    @event = Event.new
    authorize @event
    params[:rating] = 0
    params[:status] = "Pending"
  end

  def new
    @event = authorize Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.save
    authorize @event
    redirect_to events_path
  end

  def update
    authorize @event
    if params[:sub_category_id]
      sub_categorie = SubCategory.find(params[:sub_category_id])
      sub_categorie.event = @event
    end
    @event.update(event_params)
    redirect_to admin_path
  end

  def edit
  end

  def admin
    @categories = Category.all
    @sub_categories = SubCategory.all
    @events = policy_scope(Event).where("occurs_at > ?", Date.today).order(occurs_at: :asc).page params[:page]
    # unless params[:id_page].nil?
    #   @events = @events[50*params[:id_page]..50*params[:id_page]+50]
    # end
    @event = Event.new
  end

  def index

    selection_of_preferences(current_user)

    respond_to do |format|
      format.html {}
      format.js  # <-- will render `app/views/events/index.js.erb`
    end

  end

  def selection_of_preferences(current_user)
    @categories = Category.all

    categories_preferences = current_user.find_liked_items(votable_type: 'Category')
    sub_categories_preferences = current_user.find_liked_items(votable_type: 'SubCategory')



    @selected_categories = params[:categories].presence || categories_preferences.pluck(:name) || Category.pluck(:name)
    @selected_sub_categories = params[:sub_categories].presence || sub_categories_preferences.pluck(:name) || SubCategory.pluck(:name)
    # Including all sub categories of any selected category with no selected sub category
    Category.includes(:sub_categories).where(name: @selected_categories).each do |category|
      all_sub_categorie_names = category.sub_categories.pluck(:name)

      if (all_sub_categorie_names & @selected_sub_categories).count == 0
        #if no sub category selected, take the whole category
        @selected_sub_categories += all_sub_categorie_names
      end
    end

    events = policy_scope(Event).
      joins(:sub_category, :category).
      where(
        categories: { name: @selected_categories },
        sub_categories: { name: @selected_sub_categories },
        status: "Valid"
      ).
      order(occurs_at: :desc)

    @hash = {}
    date = Time.now.to_date - 1.days
    30.times do
      @hash[date += 1.day] = []
    end
    @hash.each do |date, _date_events|
      @hash[date] << events.where(occurs_at: date)
      @hash[date].flatten!
    end

    # Meteo Symbols
    meteo_events = Event.joins(:sub_category).where(sub_categories: { name: 'Météo'})
    @meteo_hash = {}
    date = Time.now.to_date - 1.days
    30.times do
      @meteo_hash[date += 1.day] = []
    end
    @meteo_hash.each do |date, _date_events|
      @meteo_hash[date] << meteo_events.where(occurs_at: date)
      @meteo_hash[date].flatten!
    end

  end

  def show
     @event = Event.find(params[:id])
    # No authorization cause not signed in
  end

  def destroy
  end

  def sync_calendar


    user = User.where(calendar_token: params[:token]).first
    return redirect_to(root_path) unless user

    selection_of_preferences(user)



    respond_to do |format|
      format.html
      format.ics do
        cal = Icalendar::Calendar.new
        filename = "Your coming up calendar"
        @hash.each do |date, events|
          events.each do |event|
              happening = Icalendar::Event.new
              happening.dtstart = DateTime.civil(date.year, date.month, date.day, 00, 00)
              happening.dtend =  DateTime.civil(date.year, date.month, date.next_day.day, 00, 00)
              happening.summary = event.headline
              cal.add_event(happening)
            end
          end
        cal.publish

        render :text =>  cal.to_ical
      end



        # send_data cal.to_ical, type: 'text/calendar', disposition: 'attachment', filename: filename
      end
  end

  private

  def set_event
    @event = Event.find(params[:id])
    authorize @event
  end

  def event_params
    params.require(:event).permit(
      :occurs_at,
      :headline,
      :headline_initial,
      :sub_category_id,
      :rating,
      :source,
      :description,
      :status)

  end

end
