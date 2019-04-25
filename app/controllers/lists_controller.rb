class ListsController < ApplicationController
before_action :set_list, except: [:create]
before_action :permit_query, only: [:show]

  def show
    # クエリに対応する値を格納したハッシュ
    sort_values = { created_at: '登録順',
                    title: 'タイトル順',
                    release_date: '公開日順' }

    # フィルター用のクエリの存在と"on"であることを確認し、あれば@moviesを絞り込む
    if params[:filter].present? && params[:filter] == "on"
      filtered_movies = @list.movies.where(check: false)
      @filter_mode = "on"
    else
      # それ以外の時は絞り込みは行わない
      filtered_movies = @list.movies
      @filter_mode = "off"
    end

    # 並び替え用のクエリがあるか確認、無かったり無効なキーならデフォルトの登録順
    if params[:sort_by].present? && sort_values.has_key?(params[:sort_by].to_sym)
      sorter = params[:sort_by].to_sym
    else
      sorter = :created_at
    end

    # 並び順用のクエリがあるか確認、無かったらデフォルトの昇順
    if params[:direction].present? && params[:direction] == "desc"
      @direction_name = direction = :desc
    else
      @direction_name = direction = :asc
    end

    # ページネーション用にMovieオブジェクト群を取り出す
    @movies = filtered_movies.order( { sorter => direction } ).page(params[:page]).per(10)
    @sort_name = sort_values[sorter]
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

  def permit_query
    @params = params.permit(:id, :sort_by, :filter, :direction).to_h
  end
end