class ListsController < ApplicationController
before_action :set_list, except: [:create]

  def show
    # 並び替え用のクエリがあるか確認
    sort_key = params[:sort_by] ? params[:sort_by].to_sym : :created_at
    # クエリはこちらで用意したもの以外は無効とする
    sort_values = { created_at:   [:created_at, '登録順'],
                    title:        [:title, 'タイトル順'],
                    release_date: [:release_date, '公開日順'] }
    raise unless sort_values.has_key?(sort_key)

    # ページネーション用にMovieオブジェクト群を取り出す
    @movies = @list.movies.order(sort_values[sort_key][0]).page(params[:page]).per(15)
    @sort_name = sort_values[sort_key][1]
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
