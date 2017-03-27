class PreferencesController < ApplicationController
  skip_after_action :verify_authorized

  def save_filters
    ActsAsVotable::Vote.by_type("User").
      where(votable_type: ["Category", "SubCategory"], voter_id: current_user.id).
      destroy_all

    @selected_categories = Category.where(name: params[:categories])

    @selected_categories.each do |category|
      category.liked_by current_user
    end

    @selected_sub_categories = SubCategory.where(name: params[:sub_categories])

    @selected_sub_categories.each do |sub_category|
      sub_category.liked_by current_user
    end

    redirect_to sync_calendar_path
  end





end
