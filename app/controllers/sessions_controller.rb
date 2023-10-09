class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to (session.delete(:redirect_to_url) || root_path), notice: 'Вход выполнен'
    else
      flash.now[:alert] = 'Ошибка входа, проверьте email и пароль'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
