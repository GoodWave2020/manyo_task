class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash.now[:danger] = t('login_failed')
      render 'new'
    end
  end
  def destroy
    session.delete(:user_id)
    flash[:notice] = t('login_succeeded')
    redirect_to new_session_path
  end
end
