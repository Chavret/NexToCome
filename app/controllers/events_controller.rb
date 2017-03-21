class EventsController < ApplicationController
  before_action :set_event, only: [:edit, :destroy, :update]

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

  def index
    @categories = Category.all
    @sub_categories = SubCategory.all
    @events = policy_scope(Event)
    @event = Event.new
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
