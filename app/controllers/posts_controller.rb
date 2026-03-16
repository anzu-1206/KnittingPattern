class PostsController < ApplicationController
  def index
    @public_patterns = Pattern.published

    if params[:category].present?
      @public_patterns = @public_patterns.where(category: params[:category])
    end

    if params[:bookmark] && user_signed_in?
      @public_patterns = current_user.bookmarked_patterns
    elsif params[:category].present?
      @public_patterns = Pattern.where(category: params[:category])
    else
      @public_patterns = Pattern.all
    end

    @q = Pattern.ransack(params[:q])
    @patterns = @q.result(distinct: true)
  end
end
