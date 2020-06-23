class Webhook::ChargesController < Webhook::ApplicationController
  protect_from_forgery except: :create

  def create
    session = Stripe::Checkout::Session.retrieve(params[:data][:object][:id])
    charge = Charge.new(
      stripe_session_id: session[:id],
      user_id: session[:metadata][:user_id],
      item_id: session[:metadata][:item_id]
    )
    charge.item.quantity.times {
      charge.lesson_tickets.build(user_id: session[:metadata][:user_id])
    }
    if charge.save
      head :created
    else
      head :internal_server_error
    end
  end
end
