class Feedback < ApplicationRecord
  belongs_to :lesson_reservation

  validates :body, presence: true, length: { maximum: 300 }
end
