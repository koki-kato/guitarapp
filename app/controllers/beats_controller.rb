class BeatsController < ApplicationController
    before_action :logged_in_user, only: [:new, :edit, :update]
    before_action :admin_or_correct_user, only: [:edit, :update]
  
    def new
      @score = Score.new
      60.times do |n|
        Beat.create!
        end
    end
    
    def edit
      @user = User.find(params[:user_id])
      @score = @user.scores.find(params[:score_id])
      @beat = @score.beats.find(params[:id])
    end
  
    def update
      @user = User.find(params[:user_id])
      @score = @user.scores.find(params[:score_id])
      @beat = @score.beats.find(params[:id])
      if @beat.update(lyric: params[:beat][:lyric], image_name: params[:beat][:image_name])
        flash[:success] = "歌詞を更新しました。"
        redirect_to user_score_url(id: params[:score_id])
      else
        render :edit      
      end
    end
  
  
    private
  
    def beat_params
      params.require(:beat).permit(:lyric)
    end
  
  end