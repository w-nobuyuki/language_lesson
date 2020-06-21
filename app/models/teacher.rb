class Teacher < ApplicationRecord
  has_many :supported_languages, dependent: :destroy
  has_many :languages, through: :supported_languages
  has_many :lessons

  mount_uploader :avatar, AvatarUploader

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }
end
