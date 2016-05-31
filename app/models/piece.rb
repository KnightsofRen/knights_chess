class Piece < ActiveRecord::Base
  enum color: [:black, :white]
  belongs_to :game
end
