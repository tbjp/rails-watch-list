require 'uri'
require 'net/http'

class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
    @bookmark = Bookmark.new
    # get_tmdb_data
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

  def get_tmdb_data
    url = URI("https://api.themoviedb.org/3/configuration")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url)
    request["accept"] = 'application/json'
    request["Authorization"] = "Bearer #{ENV['TMDB_TOKEN']}"
    raise
    response = http.request(request)
    puts response.read_body
    # raise
  end
end
