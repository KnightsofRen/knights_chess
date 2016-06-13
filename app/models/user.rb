class User < ActiveRecord::Base
  has_many :games
  include Gravtastic
  # "404, "mm", "identicon", "monsterid", "wavatar", "retro", "blank" or an absolute URL.
  gravtastic :default => "mm"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
