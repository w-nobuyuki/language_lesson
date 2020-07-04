class Charge < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_many :lesson_tickets

  validates :stripe_session_id, presence: true, uniqueness: true

  def stripe_checkout_session(success_url:, cancel_url:, user_id:)
    Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            unit_amount: item.amount,
            currency: 'jpy',
            product_data: {
              name: item.name,
              description: item.description
            }
          },
          quantity: 1
        }
      ],
      mode: 'payment',
      success_url: success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: cancel_url,
      metadata: {
        user_id: user_id,
        quantity: item.quantity,
        item_id: item.id
      }
    )
  end
end
