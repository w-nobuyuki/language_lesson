class ItemsController < ApplicationController
  def index
    @items = Item.all.order(amount: 'ASC')
  end
end
