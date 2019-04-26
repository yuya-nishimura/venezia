class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :set_params, only: :search
  require 'open-uri'

  def index
    @lists = @user.lists.page(params[:page]).per(6) if user_signed_in?
  end

  def search
    api_key = ENV["TMDB_API_KEY"]
    @keyword = params[:search]
    @page = params[:page] ? params[:page].to_i : 1

    if !@keyword.blank?
      url = URI.encode "https://api.themoviedb.org/3/search/movie?api_key=#{api_key}&query=#{@keyword}&page=#{@page}&language=ja-JP&region=JP"
      json = JSON.load(open(url))
      @results = json["results"]
      @total_results = json["total_results"]
      @total_pages = json["total_pages"]

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
    params.permit(:search, :page)
  end

end
