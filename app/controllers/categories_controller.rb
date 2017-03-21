class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.save
  end

  def index
    Category.all
  end

  def destroy
    @categorie = Category.find(category_params)
    @categorie.destroy
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
