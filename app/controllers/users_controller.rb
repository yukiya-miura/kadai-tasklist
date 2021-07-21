class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:edit, :update]

  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
    if @user == current_user
    else
      redirect_to root_url
    end
  end
  
  def update
    @user = User.find(params[:id])
    
      if @user.update(user_params)
        flash[:success] = 'ユーザー情報を更新しました。'
        redirect_to root_url
      else
        flash.now[:danger] = 'ユーザー情報の更新に失敗しました。'
        render :edit
      end   
  end 

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def destroy
    @user = User.find(params[:id]) 
    @user.destroy
      flash[:notice] = 'ユーザーを削除しました。'
      redirect_to root_url
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end