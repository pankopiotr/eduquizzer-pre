class CategoriesController < ApplicationController
  include CategoriesHelper

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_required_params)
    if @category.save
      flash.now[:success] = t(:category_created)
      render 'new'
    else
      render 'new'
    end
  end

  def destroy
    @category = Category.find_by(category_required_params)
    if @category.destroy
      flash.now[:success] = t(:category_deleted)
      render 'new'
    else
      render 'new'
    end
  end
end
