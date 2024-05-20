class BookmarksController < ApplicationController

  # This method is called when a new bookmark is being created
  def new
    # assigns the List object found by the list_id parameter to the @list instance variable
    @list = List.find(params[:list_id])
    # instantiates a new Bookmark object and assigns it to the @bookmark instance variable
    @bookmark = Bookmark.new
  end

  # This method is called when a new bookmark is being created
  def create
    # find the list that you want to create a bookmark for.
    @list = List.find(params[:list_id])
    # build a new bookmark associated with this list using the bookmark_params.
    @bookmark = @list.bookmarks.new(bookmark_params)

    # Attempt to save the bookmark
    if @bookmark.save
      # If @bookmark object successfully saved, redirect to the list path
      redirect_to list_path(@list)
    else
      puts @bookmark.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end
end
