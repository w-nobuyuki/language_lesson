class ChargesController < ApplicationController
  before_action :set_charge, only: [:show, :edit, :update, :destroy, :success, :cancel]

  def index
    @charges = Charge.all

    if params[:session_id].present? &&
      session = Stripe::Checkout::Session.retrieve(params[:session_id])

    end
  end

  def show
  end

  def new
    @charge = Charge.new
    case params[:amount]
    when "1"
      @session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [
          {
            price: 'price_1GsQ4THzEmLLomVZXKVysxqO',
            quantity: 1
          }
        ],
        mode: 'payment',
        # TODO: herokuでも動くようにする必要あり
        success_url: 'http://localhost:3000/charges?session_id={CHECKOUT_SESSION_ID}',
        cancel_url: 'http://localhost:3000/charges'
      )
    when "3"
      @session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [
          {
            price: 'price_1GsQ4nHzEmLLomVZeAbwMVXB',
            quantity: 1
          }
        ],
        mode: 'payment',
        success_url: 'http://localhost:3000/charges?session_id={CHECKOUT_SESSION_ID}',
        cancel_url: 'http://localhost:3000/charges'
      )
    when "5"
      @session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [
          {
            price: 'price_1GsQ57HzEmLLomVZ0vpvDEZj',
            quantity: 1
          }
        ],
        mode: 'payment',
        success_url: 'http://localhost:3000/charges?session_id={CHECKOUT_SESSION_ID}',
        cancel_url: 'http://localhost:3000/charges'
      )
    else
      @session = nil
    end
  end

  def edit
  end

  def create
    @charge = Charge.new charge_params
    @charge.user = current_user

    customer = Stripe::Customer.create(
      email: current_user.email,
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer:       customer.id,
      amount:         params[:amount],
      description:    "「#{@room.name}」の決済",
      currency:       'jpy',
      receipt_email:  params[:stripeEmail],
      metadata: {'仮払い' => "1回目"},
      capture: false #capture:falseにすると仮払いで処理してくれる。
    )
    respond_to do |format|
      if @charge.save
        format.html { redirect_to @charge, notice: 'Charge was successfully created.' }
      else
        format.html { render :new }
      end
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

  def success
    
  end

  def cancel
    
  end

  private
    def set_charge
      @charge = Charge.find(params[:id])
    end

    def charge_params
      params.require(:charge).permit(:amount)
    end
end
