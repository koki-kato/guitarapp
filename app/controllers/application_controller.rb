class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper
  
    $days_of_the_week = %w{日 月 火 水 木 金 土}
  
    # beforフィルター
  
    # paramsハッシュからユーザーを取得します。
    def set_user
      @user = User.find(params[:id])
    end
  
    # ログイン済みのユーザーか確認します。
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください。"
        redirect_to login_url
      end
    end
  
    # アクセスしたユーザーが現在ログインしているユーザーか確認します。
    def correct_user
      redirect_to(root_url) unless current_user?(@user)
    end
  
    # システム管理権限所有かどうか判定します。
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
  
  
    # 管理権限者、または現在ログインしているユーザーを許可します。
    def admin_or_correct_user
      @user = User.find(params[:user_id]) if @user.blank?
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "編集権限がありません。"
        redirect_to(root_url)
      end  
    end
  
  
    def without_admin_user
      @user = User.find(params[:user_id]) if @user.blank?
      if current_user.admin?
        flash[:danger] = "編集権限がありません。"
        redirect_to(root_url)
      end  
    end
  
  
    
  
  end