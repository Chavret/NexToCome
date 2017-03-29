module EventsHelper
  def category_filter_params(category_name)
    filter_params = {}

    if @selected_categories.include?(category_name)
      filter_params[:categories] = @selected_categories - [category_name]
    else
      filter_params[:categories] = @selected_categories + [category_name]
      filter_params[:last_cat] = Category.find_by(name: category_name).id
    end
    filter_params[:sub_categories] = @selected_sub_categories

    filter_params
  end

  def sub_category_filter_params(sub_category_name)
    filter_params = {}

    if @selected_sub_categories.include?(sub_category_name)
      filter_params[:sub_categories] = @selected_sub_categories - [sub_category_name]
    else
      filter_params[:sub_categories] = @selected_sub_categories + [sub_category_name]
    end
    filter_params[:last_cat] = SubCategory.find_by(name: sub_category_name).category.id
    filter_params[:categories] = @selected_categories

    filter_params
  end
end
