class User < ApplicationRecord
  has_many :charges, dependent: :destroy
  has_many :lesson_tickets, dependent: :destroy
  has_many :lesson_reservations, through: :lesson_tickets
  has_many :notifications, through: :lesson_reservations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }
end
