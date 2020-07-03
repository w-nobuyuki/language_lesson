require 'rails_helper'

Rails.describe 'Items#index', type: :system do
  let!(:user) { create(:user) }
  let!(:item_1) { create(:item_1) }
  let!(:item_3) { create(:item_3) }
  let!(:charge) { create(:charge, item: item_1, user: user) }
  let!(:lesson_ticket) { create(:lesson_ticket, user: user, charge: charge) }
  before do
    sign_in_user(user)
    visit items_path
  end

  it '残チケット数が表示されていること' do
    expect(page).to have_content '残チケット数は 1 枚です。'
  end

  it 'チケット購入プランの一覧が表示されていること' do
    titles = all('.card-header').map(&:text)
    expect(titles).to include(item_1.name, item_3.name)
  end

  it '購入をクリックするとStripeの支払い画面にリダイレクトすること'
end