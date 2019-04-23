class HomeController < ApplicationController
  require 'open-uri'

  def index
    @lists = @user.lists.page(params[:page]).per(6)
  end

  def search
    api_key = ENV["TMDB_API_KEY"]
    keyword = set_params[:search]

    if !keyword.blank?
      url = URI.encode "https://api.themoviedb.org/3/search/movie?api_key=#{api_key}&query=#{keyword}&page=1&language=ja-JP&region=JP"
      json = JSON.load(open(url))
      @results = json["results"]
      @total_results = json["total_results"]

      # セレクトボックスのリストにはページネーションをかけない
      @lists = @user.lists
      render 'results'
    else
      flash[:danger] = '検索ワードを入力して下さい'
      redirect_to root_url
    end
  end

  private

  # def set_lists
  #   @lists = @user.lists.page(params[:page]).per(6) if user_signed_in?
  # end

  def set_params
    params.require(:home).permit(:search)
  end

end
