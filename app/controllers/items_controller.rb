class ItemsController < ApplicationController
  def index
    @items = Item.all.order(amount: 'ASC')
    # stripe からのリダイレクトは別ルーティングにしたほうがコンバーション計測などにも役立てそう
    # 別アクションにすることで目的がハッキリして、後から読みやすい
    if params[:session_id].present? && Stripe::Checkout::Session.retrieve(params[:session_id])
      flash.now[:notice] = 'チケットの購入が完了しました。チケット数の反映は少し時間がかかる場合があります。'
    end
  end
end
