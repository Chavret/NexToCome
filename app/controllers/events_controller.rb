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

    redirect_to admin_path
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
    @events = policy_scope(Event).order(occurs_at: :asc)

    @event = Event.new
  end

  def index
    @selected_categories = params[:categories].presence || Category.pluck(:name)
    @categories = Category.all
    events = policy_scope(Event).
      joins(:category).
      where(categories: { name: @selected_categories }).
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
  end

  def destroy
  end

  def show
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
