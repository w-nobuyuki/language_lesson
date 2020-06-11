class Charge < ApplicationRecord
  belongs_to :user

  # TODO: amountは1,3,5のみ受け付けるようにする
end
