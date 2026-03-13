class PostsController < ApplicationController
  def index
    @public_patterns = Pattern.published

    if params[:category].present?
      @public_patterns = @public_patterns.where(category: params[:category])
    end

    @q = Pattern.ransack(params[:q])
    @patterns = @q.result(distinct: true)
  end
end
