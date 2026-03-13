class PostsController < ApplicationController
  def index
    @public_patterns = Pattern.published

    @q = Pattern.ransack(params[:q])
    @patterns = @q.result(distinct: true)
  end
end
