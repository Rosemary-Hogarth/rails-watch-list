class ListsController < ApplicationController

  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
    @movies = @list.movies
    @movie = Movie.new
    @bookmarks = @list.bookmarks.includes(:movie)
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)

    if @list.save
      redirect_to @list, notice: "List was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to root_path, notice: 'List was successfully deleted.'
  end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
