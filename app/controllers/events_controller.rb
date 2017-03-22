class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :destroy, :update]
  skip_after_action :verify_authorized, only: [:admin]


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
    redirect_to events_path
  end

  def edit
  end

  def admin
    @categories = Category.all
    @sub_categories = SubCategory.all
    @events = policy_scope(Event)
    @event = Event.new
  end

  def index
    # TODO: update line below to take into account liked items

    @categories = Category.all

    categories_preferences = []
    sub_categories_preferences = []

    current_user.find_liked_items.each do |preference|
      categories_preferences << preference if preference.class == Category
      sub_categories_preferences << preference if preference.class == SubCategory
    end

    @selected_categories = params[:categories].presence || categories_preferences.pluck(:name) || Category.pluck(:name)
    @selected_sub_categories = params[:sub_categories].presence || sub_categories_preferences.pluck(:name) || SubCategory.pluck(:name)

    events = policy_scope(Event).
      joins(:category).
      where(categories: { name: @selected_categories }, sub_categories: { name: @selected_sub_categories}).
      joins(:sub_category).
      where(sub_categories: { name: @selected_sub_categories}).
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

  def destroy
  end

  def show
  end

  private

  def set_event
    @event = Event.find(:id)
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
