class PostsController < ApplicationController
  def index
    @public_patterns = Pattern.where(is_public: true).order(created_at: :desc)
  end
end
