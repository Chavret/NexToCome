class SubCategoriesController < ApplicationController

  def new
    @sub_category = SubCategory.new
  end

  def create
    @sub_category = SubCategory.new(params_sub_category)
    @sub_category.save
  end

  def index
    @sub_categories = SubCategory.all
  end

  def destroy
    @sub_categorie = Category.find(params_sub_category)
    @sub_categorie.destroy
  end

  private

  def params_sub_category
    params.require(:sub_category).permit(:category_id, :name)
  end

end
