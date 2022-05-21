class SessionsController < ApplicationController

  def new
  end

  def create
    unless params[:commit] == "ログイン"
      
      (user = User.find_or_create_from_auth_hash(auth_hash))
      log_in user
      redirect_to root_path
    else
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        if current_user.admin == true
          redirect_back_or root_url
        else
          redirect_back_or root_url
        end
      else
        flash.now[:danger] = '認証に失敗しました。'
        render :new
      end
    end
  end


  def destroy
     # ログイン中の場合のみログアウト処理を実行します。
    log_out if logged_in?
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

end