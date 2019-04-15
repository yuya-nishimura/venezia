class HomeController < ApplicationController
  require 'open-uri'

  def index
  end

  def search
    keyword = set_params[:search]
    url = URI.encode "https://api.themoviedb.org/3/search/movie?api_key=b80d7b2dcc71906bb510ce9d4b43b879&query=#{keyword}&language=ja-JP"
    @movies = JSON.load(open(url))["results"]
    render 'show'
  end
  
  private

  def set_params
    params.require(:home).permit(:search)
  end
  
end
