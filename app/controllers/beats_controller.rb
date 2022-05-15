class BeatsController < ApplicationController
    before_action :logged_in_user, only: [:show, :new, :index, :edit, :update, :destroy]
    before_action :admin_user, only: [:show, :new, :index, :edit, :update, :destroy]
  
    def index
      @scores = Score.all
    end
  
    def show
      @score = Score.find(params[:id])
    end
  
    def new
      @score = Score.new
      60.times do |n|
        Beat.create!
        end
    end
    
    def edit
      @beats = Beat.find_by(score_id: params[:score_id])
    end
  
    def update
      @beat = Beat.find(params[:score_id])
      if @beat.update(lyric: params[:lyric], image_name: params[:image_name])
       
        flash[:success] = "歌詞を更新しました。"
        redirect_to score_url
      else
        render :edit      
      end
    end
  
    def create
      @score = Score.new(score_params)
      if @score.save
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
  
    def beat_params
      params.require(:beat).permit(:lyric)
    end
  
  end