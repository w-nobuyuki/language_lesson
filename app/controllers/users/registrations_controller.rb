class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def create
    @user = User.new(sign_up_params)
    @user.lesson_tickets.build
    if @user.save
      sign_in(@user)
      redirect_to root_path, notice: 'ログインしました。'
    else
      render :new
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name, :password, :password_confirmation])
  end
end
