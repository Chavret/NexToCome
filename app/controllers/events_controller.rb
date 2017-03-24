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
    @events = policy_scope(Event).where("occurs_at > ?", Date.today).where(status: "Pending").order(occurs_at: :asc).page params[:page]
    # unless params[:id_page].nil?
    #   @events = @events[50*params[:id_page]..50*params[:id_page]+50]
    # end
    @event = Event.new
  end

  def index

    @categories = Category.all

    categories_preferences = current_user.find_liked_items(votable_type: 'Category')
    sub_categories_preferences = current_user.find_liked_items(votable_type: 'SubCategory')

    @selected_categories = params[:categories].presence || categories_preferences.pluck(:name) || Category.pluck(:name)
    @selected_sub_categories = params[:sub_categories].presence || sub_categories_preferences.pluck(:name) || SubCategory.pluck(:name)
    # Including all sub categories of any selected category with no selected sub category
    Category.includes(:sub_categories).where(name: @selected_categories).each do |category|
      all_sub_categorie_names = category.sub_categories.pluck(:name)

      if (all_sub_categorie_names & @selected_sub_categories).count == 0
        @selected_sub_categories += all_sub_categorie_names
      end
    end

    events = policy_scope(Event).
      joins(:sub_category, :category).
      where(
        categories: { name: @selected_categories },
        sub_categories: { name: @selected_sub_categories }
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

    respond_to do |format|
      format.html {}
      format.js  # <-- will render `app/views/events/index.js.erb`
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
