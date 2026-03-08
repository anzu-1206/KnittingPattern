class MakepatternsController < ApplicationController
  def index
  end

  def new
  end

  def aboutme
  end

  def create
    @pattern = Pattern.new(pattern_params)
    
    if @pattern.save
      # 保存成功：JS側に成功を伝える
      render json: { id: @pattern.id, status: 'success' }, status: :created
    else
      # 保存失敗：エラーメッセージを返す
      render json: { errors: @pattern.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def pattern_params
    # 送られてくるパラメータを許可する
    params.require(:pattern).permit(:title, :start_type, :data)
  end
end
