class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
    @bookmark = Bookmark.new
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to list_path(@list)
    else
      render 'lists/show', status: :unprocessable_entity # 422
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
