class ScoresController < ApplicationController
  before_action :logged_in_user, only: [:show, :new, :index, :edit, :update, :destroy]
  before_action :admin_user, only: [:show, :new, :index, :edit, :update, :destroy]

  def index
    @scores = Score.all
  end

  def show
    @score = Score.find(params[:id])
    @beats = @score.beats.all
  end

  def new
    @score = Score.new
  end
  
  def edit
    @score = Score.find(params[:id])
  end

  def update
    @Score = Score.find(params[:id])
    if @score.update(score_params)
      flash[:success] = "楽譜を更新しました。"
      redirect_to scores_url
    else
      render :edit      
    end
  end

  def create
    
    @score = Score.new(score_params)
    if @score.save
      60.times do |n|
        @score.beats.create
        end
      byebug
        
      flash[:success] = '新規作成に成功しました。'
      redirect_to scores_url
    else
      render :new
    end
  end

  def destroy
    @score = Score.find(params[:id])
    @score.destroy
    flash[:success] = "#{@score.title}のデータを削除しました。"
    redirect_to scores_url
  end

  private

  def score_params
    params.require(:score).permit(:title)
  end

end