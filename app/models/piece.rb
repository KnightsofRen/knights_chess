class Piece < ActiveRecord::Base
  enum colro: [:black,:white]
  belongs_to :game
end
