class PreferencesController < ApplicationController
  skip_after_action :verify_policy_scoped

  def save_filters

    Category.all.each do |category|
      category.disliked_by current_user
    end

    @selected_categories = []
    params[:categories].each do |category|
      @selected_categories << Category.find_by(name: category)
    end

    @selected_categories.each do |category|
      category.liked_by current_user
    end

    # TODO: reset votes plus set votes based on params[:categories]
    redirect_to events_path
  end
end
