# frozen_string_literal: true

class Piece < ApplicationRecord
  belongs_to :attempt
  belongs_to :task
end
