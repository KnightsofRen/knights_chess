class Game < ActiveRecord::Base
    scope :available, -> {where((@games.player_white_id == nil) || (@games.player_black_id == nil)) }
    enum status: [:safe, :check, :checkmate]
end
