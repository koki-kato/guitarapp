class ScoresController < ApplicationController
  before_action :logged_in_user, only: [:show, :new, :index, :edit, :update, :destroy]
  before_action :admin_or_correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
    @scores = Score.all
  end

  def show
    @i = 0
    if params[:create_id].present?
      @user = User.find(params[:create_id])
    else
      @user = User.find(params[:user_id])
    end  
    @score = @user.scores.find(params[:id])
    @beats = @score.beats.all
  end

  def new
    @user = User.find(params[:user_id])
    @score = @user.scores.new
  end
  
  def edit
    @user = User.find(params[:user_id])
    @score = @user.scores.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @score = @user.scores.find(params[:id])
    if @score.update(score_params)
      flash[:success] = "楽譜を更新しました。"
      redirect_to user_scores_url
    else
      render :edit      
    end
  end

  def create
    @user = User.find(params[:user_id])
    @score = @user.scores.new(score_params)
    if @score.save
      60.times do |n|
        @score.beats.create
        end
      flash[:success] = '新規作成に成功しました。'
      redirect_to user_scores_url
    else
      flash[:danger] = '入力が不足しています。'
      render :new
    end
  end

  def destroy
    @score = Score.find(params[:id])
    @score.destroy
    flash[:success] = "#{@score.title}のデータを削除しました。"
    redirect_to user_scores_url
  end

  private

  def score_params
    params.require(:score).permit(:title, :artist, :capo)
  end

  

end