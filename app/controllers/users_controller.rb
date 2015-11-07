class UsersController < ApplicationController
  def new
    @user = User.new user_params
  end

  def create
    @user = User.new user_params
    if @user.valid?
      @user.save
      redirect_to root_path, notice: 'User was created'
    else
      render :new
    end
  end

  private
  def user_params
    params[:user].permit :email, :password, :password_confirmation if params[:user]
  end
end
