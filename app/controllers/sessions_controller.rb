class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email params[:login][:email]
    unless user && user.authenticate(params[:login][:password])
      flash[:alert] = 'Wrong email or password'
      return render :new
    end

    session[:user_id] = user.id
    redirect_to root_path, notice: 'User logged in'
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
