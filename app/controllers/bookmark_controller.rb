class BookmarkController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    current_user.bookmarks.create(post: @post)
    
    render turbo_stream: turbo_stream.replace(
      "bookmark_button_#{@post.id}",
      partial: "bookmarks/bookmark",
      locals: { post: @post }
    )
  end

  def destroy
    @post = Post.find(params[:post_id])
    bookmark = current_user.bookmarks.find_by(post: @post)
    bookmark.destroy
    
    render turbo_stream: turbo_stream.replace(
      "bookmark_button_#{@post.id}",
      partial: "bookmarks/bookmark",
      locals: { post: @post }
    )
  end
end
