class PatternsController < ApplicationController
  def index
    @patterns = Pattern.all
  end

  class PatternsController < ApplicationController
  # 保存処理 (Ajaxから呼ばれる)
  def create
    @pattern = current_user.patterns.build(pattern_params)
    if @pattern.save
      render json: { status: 'success' }
    else
      render json: { status: 'error' }, status: 422
    end
  end

  # 詳細表示 (保存した編み図を見る)
  def show
    @pattern = Pattern.find(params[:id])
    # @pattern.pattern_data を使ってビューで編み図を復元できる！
  end

  private
  def pattern_params
    # ここで pattern_data や grid_width も許可する
    params.require(:pattern).permit(:name, :pattern_data, :grid_width, :grid_height, :yarn, :hook, ...)
  end
end
end
