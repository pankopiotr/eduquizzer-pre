# frozen_string_literal: true

class CategoriesController < ApplicationController
  include CategoryExtension

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_required_params)
    flash.now[:success] = t(:category_created) if @category.save
    render 'new'
  end

  def destroy
    @category = Category.find_by(category_required_params)
    flash.now[:success] = t(:category_deleted) if @category&.destroy
    render 'new'
  end
end
