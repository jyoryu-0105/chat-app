class RoomsController < ApplicationController
  
  def index
    
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    room = Room.find(params[:id])
    # 削除するルームを特定
    room.destroy
    # 特定したroomを削除
    redirect_to root_path
    # トップページへ遷移
  end

  private
  def room_params
    params.require(:room).permit(:name, user_ids: [])
  end
end
