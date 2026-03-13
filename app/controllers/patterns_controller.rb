class PatternsController < ApplicationController
  def index
    @patterns = current_user.patterns

    if params[:category].present?
      @patterns = @patterns.where(category: params[:category])
    end

    @q = @patterns.ransack(params[:q])
    @patterns = @q.result(distinct: true)
  end

  def new
    @pattern = Pattern.new
  end

  def create
    @pattern = current_user.patterns.build(pattern_params)

    attach_image_to_pattern(@pattern)

    if @pattern.save
      render json: { status: 'success', redirect_url: patterns_path }
    else
      render json: { status: 'error', errors: @pattern.errors.full_messages }, status: 422
    end
  end

  def show
    @pattern = Pattern.find(params[:id])
  end

  def edit
    @pattern = current_user.patterns.find(params[:id])
  end

  def update
    @pattern = current_user.patterns.find(params[:id])

    attach_image_to_pattern(@pattern)

    if @pattern.update(pattern_params)
      render json: { status: 'success', redirect_url: patterns_path }
    else
      render json: { status: 'error', errors: @pattern.errors.full_messages }, status: 422
    end
  end

  def destroy
    @pattern = current_user.patterns.find(params[:id])
    @pattern.destroy
    flash[:notice] = "パターンを削除しました"
    redirect_to patterns_path
  end

  private
  def pattern_params
    params.require(:pattern).permit(
      :title, :introduction, 
      :pattern_data, :grid_width, :grid_height, 
      :is_public, :category
    )
  end

  def attach_image_to_pattern(pattern)
    image_data = params.dig(:pattern, :image_data)
    return unless image_data.present?

    base64_image = image_data.split(',').last
    decoded_image = Base64.decode64(base64_image)

    pattern.image.attach(
      io: StringIO.new(decoded_image),
      filename: "pattern_#{Time.zone.now.to_i}.png",
      content_type: 'image/png'
    )
  end
end
