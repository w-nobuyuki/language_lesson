module AuthenticationHelpers
  def sign_in_user(user)
    visit new_user_session_path
    fill_in 'user[email]',	with: user.email
    fill_in 'user[password]',	with: user.password
    click_button 'ログイン'
  end

  def sign_in_teacher(teacher)
    visit new_teacher_session_path
    fill_in 'teacher[email]',	with: teacher.email
    fill_in 'teacher[password]',	with: teacher.password
    click_button 'ログイン'
  end

  def sign_in_admin(admin)
    visit new_admin_session_path
    fill_in 'admin[email]',	with: admin.email
    fill_in 'admin[password]',	with: admin.password
    click_button 'ログイン'
  end
end
