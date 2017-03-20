class CategoriesController < ApplicationController
  before_action :get_category, only: {:create}

  def new
    @category = Category.new
  end

  def create
  end

  def index
    Category.all
  end

  private

  def get_sub_category
    params.require(:category).permit(:name)
  end

end
