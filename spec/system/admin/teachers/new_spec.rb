require 'rails_helper'

RSpec.describe 'Admin::Teachers#new', type: :system do
  let!(:admin) { create(:admin) }
  let!(:teacher) { create(:teacher) }
  before do
    visit new_admin_session_path
    fill_in 'admin[email]',	with: 'admin@tryout.com'
    fill_in 'admin[password]',	with: 'password'
    click_button 'ログイン'
    visit admin_teachers_path
  end
end