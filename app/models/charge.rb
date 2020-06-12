class Charge < ApplicationRecord
  belongs_to :user
  has_many :lesson_tickets

  # TODO: amountは1,3,5のみ受け付けるようにする
end
