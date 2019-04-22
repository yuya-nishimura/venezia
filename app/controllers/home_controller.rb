class HomeController < ApplicationController
  require 'open-uri'
  before_action :set_user_and_lists

  def index
  end

  def search
    api_key = ENV["TMDB_API_KEY"]
    keyword = set_params[:search]

    if !keyword.blank?
      url = URI.encode "https://api.themoviedb.org/3/search/movie?api_key=#{api_key}&query=#{keyword}&language=ja-JP"
      json = JSON.load(open(url))
      @results = json["results"]
      render 'results'
    else
      flash[:danger] = '検索ワードを入力して下さい'
      redirect_to root_url
    end
  end

  private

  def set_user_and_lists
    if user_signed_in?
      @user = current_user
      @lists = @user.lists
    end
  end

  def set_params
    params.require(:home).permit(:search)
  end

end
