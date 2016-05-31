class Game < ActiveRecord::Base
  enum status: [ :safe, :check, :checkmate ]
end
