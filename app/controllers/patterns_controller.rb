class PatternsController < ApplicationController
  def index
    @patterns = Pattern.all
  end

  def create
    @pattern = current_user.patterns.build(pattern_params)
    if @pattern.save
      render json: { status: 'success' }
    else
      render json: { status: 'error' }, status: 422
    end
  end

  def show
    @pattern = Pattern.find(params[:id])
  end

  private
  def pattern_params
    params.require(:pattern).permit(
      :name, :introduction, 
      :pattern_data, :grid_width, :grid_height, 
      :is_public, :category
    )
  end
end
