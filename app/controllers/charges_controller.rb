class ChargesController < ApplicationController
  protect_from_forgery except: :create
  skip_before_action :authenticate_user!, only: :create

  def index
    @charges = Charge.all
  end

  def show; end

  def new
    @charge = Charge.new
    case params[:amount]
    when '1'
      @session = @charge.stripe_checkout_session(price: 'price_1GsQ4THzEmLLomVZXKVysxqO', root_url: root_url)
    when '3'
      @session = @charge.stripe_checkout_session(price: 'price_1GsQ4nHzEmLLomVZeAbwMVXB', root_url: root_url)
    when '5'
      @session = @charge.stripe_checkout_session(price: 'price_1GsQ57HzEmLLomVZ0vpvDEZj', root_url: root_url)
    else
      @session = nil
    end
  end

  def edit; end

  def create
    # if Stripe::PaymentIntent.retrieve(charge_params[:id])
      return if Charge.find_by(stripe_payment_intent_id: charge_params[:id]).present?

      charge = current_user.charges.build(
        stripe_payment_intent_id: charge_params[:id]
      )
      case charge_params[:amount]
      when 2000
        charge.lesson_tickets.build
      when 5000
        3.times { charge.lesson_tickets.build }
      when 7500
        5.times { charge.lesson_tickets.build }
      else
        return
      end
    # end
    respond_to do |format|
      format.xml { render head :ok } if charge.save
    end
  end

  def update
    respond_to do |format|
      if @charge.update(charge_params)
        format.html { redirect_to @charge, notice: 'Charge was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @charge.destroy
    respond_to do |format|
      format.html { redirect_to charges_url, notice: 'Charge was successfully destroyed.' }
    end
  end

  private
    def charge_params
      params.permit(:id, :amount)
    end
end
