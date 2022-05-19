class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index]
  before_action :admin_or_correct_user, only: [:edit, :update, :destroy]

  

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit      
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end

 

  def import
    if params[:file].blank?
      flash[:danger] = "ファイルを選択してください"
      redirect_to users_url 
    else 
      User.import(params[:file])
      flash[:success] = "アカウント情報を追加しました。"
      redirect_to users_url
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email,:password, :password_confirmation)
    end


end