class SubCategoriesController < ApplicationController
  before_action :get_sub_category, only: {:create}

  def new
    @sub_category = SubCategory.new
  end

  def create
  end

  def index
    @sub_categories = SubCategory.all
  end

  private

  def get_sub_category
    params.require(:sub_category).permit(:category_id, :name)
  end

end
