class EventsController < ApplicationController
  before_action :get_event, only: {:edit, :destroy, :show, :create}

  def new
    @event = Event.new
  end

  def create
  end

  def update
  end

  def edit
  end

  def index
  end

  def destroy
  end

  def show
  end

  private

  def get_event
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
