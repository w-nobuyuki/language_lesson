class User < ApplicationRecord
  has_many :charges
  has_many :lesson_tickets, through: :charges
  has_many :lesson_reservations
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
