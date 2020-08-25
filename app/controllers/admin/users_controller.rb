class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :current_user
  before_action :administrate_user
  def index
    @users = User.all.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user.id)
    else
      render :new
    end
  end

  def show
  end

  def favorites
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id)
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice:t('notice.delete')
    else
      redirect_to admin_users_path, notice:t('notice.admin')
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :admin, :password,
                                                :password_confirmation)
  end
  def set_user
    @user = User.find(params[:id])
  end
end
