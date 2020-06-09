class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザ登録完了'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザ登録エラー'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
