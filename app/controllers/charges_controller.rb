class ChargesController < ApplicationController
  before_action :set_item, only: :new

  def new
    charge = @item.charges.build
    @session = charge.stripe_checkout_session(
      redirect_url: items_url,
      user_id: current_user.id
    )
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end
end
