class PreferencesController < ApplicationController
  skip_after_action :verify_authorized

  def save_filters
    # Remove Category and SubCategory preferences
    ActsAsVotable::Vote.by_type("User").
      where(votable_type: ["Category", "SubCategory"], voter_id: current_user.id).
      destroy_all

    # Category.all.each do |category|
    #   category.disliked_by current_user
    # end

    # @selected_categories = []
    # params[:categories].each do |category|
    #   @selected_categories << Category.find_by(name: category)
    # end

    @selected_categories = Category.where(name: params[:categories])

    @selected_categories.each do |category|
      category.liked_by current_user
    end

    # Check >

    # SubCategory.all.each do |sub_category|
    #   sub_category.disliked_by current_user
    # end

    @selected_sub_categories = SubCategory.where(name: params[:sub_categories])

    @selected_sub_categories.each do |sub_category|
      sub_category.liked_by current_user
    end

    # Check <

    redirect_to events_path
  end
end
