class MoviesController < ApplicationController
before_action :set_movie, only: [:check, :destroy]

  def create
    if @user.lists.blank?
      flash[:warning] = 'リストを作成して下さい'
      redirect_to root_url
    else
      @selected_list = @user.lists.find(params[:movie][:list_id])
      @movie = @selected_list.movies.build(movie_params)

      if @movie.save
        respond_to do |format|
          @message = "\"#{@movie.title}\"がリスト\"#{@selected_list.name}\"に追加されました"
          @type = "info"
          format.js
        end
      else
        respond_to do |format|
          error_messages = @movie.errors.full_messages.join(', ')
          @message = error_messages
          @type = "warning"
          format.js
        end
      end
    end
  end

  def check
    @movie.toggle!(:check)
    respond_to do |format|
      @mid = @movie.id
      format.js
    end
  end

  def destroy
    # メッセージでリスト名を出すため、削除する前に名前を抜く
    @list_name = @movie.list.name
    @movie.destroy
    respond_to do |format|
      @message = "\"#{@movie.title}\"がリスト\"#{@list_name}\"から削除されました"
      @type = "info"
      @mid = @movie.id
      format.js
    end
  end

  private

  def set_movie
    @movie = @user.movies.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :description, :release_date, :poster)
  end

end