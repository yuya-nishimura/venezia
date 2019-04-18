class ListsController < ApplicationController
  def new
  end

  def show
    @list = current_user.lists.find(params[:id])
  end

  def edit
  end

  def create
    @list = current_user.lists.build(list_params)
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
  end

  def destroy
  end

  private

  def list_params
    params.require(:list).permit(:name, :description)
  end
end
