class User < ActiveRecord::Base
  has_many :games

  include Gravtastic
  # "404, "mm", "identicon", "monsterid", "wavatar", "retro", "blank" or an absolute URL.
  gravtastic default: 'mm'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :set_default_values

  private

  def set_default_values
    update_attributes(
      games_as_white: 0,
      won_games: 0,
      won_games_as_white: 0,
      lost_games: 0,
      lost_games_via_forfeit: 0,
      tied_games: 0
    )
  end
end
