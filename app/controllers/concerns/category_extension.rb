# frozen_string_literal: true

module CategoryExtension
  extend ActiveSupport::Concern

  private

    def category_required_params
      params.require(:category).permit(:name)
    end
end