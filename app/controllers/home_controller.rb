class HomeController < ApplicationController
  require 'open-uri'

  def index
    @user = current_user
  end

  def search
    api_key = ENV["TMDB_API_KEY"]
    keyword = set_params[:search]
    url = URI.encode "https://api.themoviedb.org/3/search/movie?api_key=#{api_key}&query=#{keyword}&language=ja-JP"
    json = JSON.load(open(url))

    @movies = json["results"]
    render 'show'
  end

  private

  def set_params
    params.require(:home).permit(:search)
  end

end
