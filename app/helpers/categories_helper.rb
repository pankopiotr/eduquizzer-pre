module CategoriesHelper
  private

    def category_required_params
      params.require(:category).permit(:name)
    end
end
