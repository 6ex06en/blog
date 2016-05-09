class SessionsController < ApplicationController

  before_action :already_loged, only: [:create]

  def new
  end

  def create
    @user = User.find_by(name: params[:session][:name])
    if @user && @user.authenticate(params[:session][:password])
      sign_in @user
      redirect_to root_path
    else
      flash.now[:danger] = "Неверный пользователь или пароль"
      render "new"
    end
  end

  def destroy
    sign_out if current_user
    redirect_to root_path
  end

  private

  def already_loged
    if current_user
      flash[:danger] = "Вы уже авторизовались!"
      redirect_to root_path
    end
  end

end
