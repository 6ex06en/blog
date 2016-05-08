class SessionsController < ApplicationController
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
end
