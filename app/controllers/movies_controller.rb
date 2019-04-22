class MoviesController < ApplicationController
  def new
  end

  def show
  end

  def edit
  end

  def create
    if @user.lists.blank?
      flash[:warning] = 'リストを作成して下さい'
      redirect_to root_url
    else
      @selected_list = @user.lists.find(params[:movie][:list_id])
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
  end

  def update
  end

  def destroy
    @movie = @user.movies.find(params[:id])
    @selected_list = @movie.list

    @movie.destroy
    flash[:success] = "\"#{@movie.title}\"がリスト\"#{@selected_list.name}\"から削除されました"
    redirect_to @selected_list
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :release_date, :poster)
  end

end
