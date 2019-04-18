class ListsController < ApplicationController
  def new
  end

  def show
    @list = current_user.lists.find(params[:id])
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
end
