class Item < ApplicationRecord
  has_many :charges

  validates :name, presence: true
  validates :amount, presence: true
  validates :quantity, presence: true
end
