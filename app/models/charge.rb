class Charge < ApplicationRecord
  belongs_to :user
  has_many :lesson_tickets

  # TODO: amountは1,3,5のみ受け付けるようにする

  def stripe_checkout_session(price:, root_url:)
    Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price: price,
          quantity: 1
        }
      ],
      mode: 'payment',
      success_url: root_url + 'lesson_tickets?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: root_url + 'lesson_tickets'
    )
  end
end
