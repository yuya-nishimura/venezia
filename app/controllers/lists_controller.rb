class ListsController < ApplicationController
before_action :set_list, except: [:create]

  def show
    # ページネーション用にMovieオブジェクト群を取り出す
    @movies = @list.movies.page(params[:page]).per(15)
  end

  def create
    @list = @user.lists.build(list_params)
    if @list.save
      flash[:success] = "リストが作成されました"
      redirect_to root_url
    else
      error_messages = @list.errors.full_messages.join(', ')
      flash[:danger] = error_messages
      redirect_to root_url
    end
  end

  def update
    if @list.update_attributes(list_params)
      flash[:success] = 'リストが更新されました'
      redirect_to root_url
    else
      error_messages = @list.errors.full_messages.join(', ')
      flash[:danger] = error_messages
      redirect_to root_url
    end
  end

  def destroy
    @list.destroy
    flash[:success] = "リストが削除されました"
    redirect_to root_url
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :description)
  end
end
