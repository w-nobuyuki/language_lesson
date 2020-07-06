class Item < ApplicationRecord
  has_many :charges, dependent: :restrict_with_exception

  validates :name, presence: true, length: { maximum: 50 }
  validates :amount, presence: true,
                     numericality: {
                       only_integer: true,
                       greater_than_or_equal_to: 0,
                       allow_blank: true
                     }
  validates :quantity, presence: true,
                       numericality: {
                         only_integer: true,
                         greater_than_or_equal_to: 0,
                         allow_blank: true
                       }
end
