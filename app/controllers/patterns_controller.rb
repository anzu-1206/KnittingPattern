class PatternsController < ApplicationController
  def index
    @patterns = Pattern.all
  end

  def create
    @pattern = current_user.patterns.build(pattern_params)
    if @pattern.save
      render json: { status: 'success', redirect_url: patterns_path }
    else
      render json: { status: 'error', errors: @pattern.errors.full_messages }, status: 422
    end
  end

  def show
    @pattern = Pattern.find(params[:id])
  end

  private
  def pattern_params
    params.require(:pattern).permit(
      :title, :introduction, 
      :pattern_data, :grid_width, :grid_height, 
      :is_public, :category
    )
  end
end
