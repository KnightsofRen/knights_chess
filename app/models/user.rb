class User < ActiveRecord::Base
<<<<<<< HEAD
  has_many :games
=======
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
>>>>>>> bbc1b5425e85b5136ce32d8343f9f6f7869339da
end
