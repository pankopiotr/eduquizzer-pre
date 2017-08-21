# frozen_string_literal: true

module ApplicationExtension
  extend ActiveSupport::Concern

  private

    def signed_in_user?
      return if signed_in?
      flash[:danger] = t(:signin_first)
      redirect_to root_url
    end

    def correct_user?
      return unless params[:id]
      @user = User.find(params[:id])
      return if @user == current_user
      flash[:danger] = t(:access_denied)
      redirect_to(root_url)
    end

    def admin_user?
      return if current_user&.admin?
      flash[:danger] = t(:access_denied)
      redirect_to(root_url)
    end
end