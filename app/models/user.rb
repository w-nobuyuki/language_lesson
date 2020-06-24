class User < ApplicationRecord
  # dependent
  has_many :charges
  has_many :lesson_tickets
  has_many :lesson_reservations
  # いらなさそう
  has_many :notifications, through: :lesson_reservations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }
end
