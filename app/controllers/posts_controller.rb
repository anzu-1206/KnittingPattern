class PostsController < ApplicationController
  def index
    @public_patterns = Pattern.published

    if params[:category].present?
      @public_patterns = @public_patterns.where(category: params[:category])
    end

    if params[:bookmark] && user_signed_in?
      @public_patterns = current_user.bookmarked_patterns.published
    elsif params[:category].present?
      @public_patterns = Pattern.published.where(category: params[:category])
    else
      @public_patterns = Pattern.published
    end

    @q = @public_patterns.ransack(params[:q])
    @public_patterns = @q.result(distinct: true)
  end
end
