class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def create
    @pattern = Pattern.find(params[:pattern_id])
    current_user.bookmarks.create(pattern: @pattern)
    
    render turbo_stream: turbo_stream.replace(
      "bookmark_button_#{@pattern.id}",
      partial: "bookmarks/bookmark",
      locals: { pattern: @pattern }
    )
  end

  def destroy
    @pattern = Pattern.find(params[:pattern_id])
    bookmark = current_user.bookmarks.find_by(pattern: @pattern)
    bookmark.destroy
    
    render turbo_stream: turbo_stream.replace(
      "bookmark_button_#{@pattern.id}",
      partial: "bookmarks/bookmark",
      locals: { pattern: @pattern }
    )
  end
end
