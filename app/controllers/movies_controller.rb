class MoviesController < ApplicationController
  def new
  end

  def show
    @movie = current_user.movies.find(params[:id])
  end

  def edit
  end

  def create
    @selected_list = current_user.lists.find(params[:movie][:list_id])
    @movie = @selected_list.movies.build(movie_params)
    if @movie.save
      flash[:success] = "\"#{@movie.title}\"がリスト\"#{@selected_list.name}\"に追加されました"
      redirect_to root_url
    else
      error_messages = @movie.errors.full_messages.join(', ')
      flash[:danger] = error_messages
      redirect_to root_url
    end
  end

  def update
  end

  def destroy
    @movie = current_user.movies.find(params[:id])
    @selected_list = @movie.list

    @movie.destroy
    flash[:success] = "\"#{@movie.title}\"がリスト\"#{@selected_list.name}\"から削除されました"
    redirect_to root_url
  end

  private

  def movie_params
    params.require(:movie).permit(:title)
  end

end
