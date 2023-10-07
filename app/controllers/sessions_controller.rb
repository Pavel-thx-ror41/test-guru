class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id

      if session[:redirect_to_url]
        redirect_to session.delete(:redirect_to_url), notice: 'Вход выполнен'
      else
        redirect_to root_path, notice: 'Вход выполнен'
      end
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
