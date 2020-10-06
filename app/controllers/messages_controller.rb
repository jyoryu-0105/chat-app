class MessagesController < ApplicationController
  
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:user)
    # チャットルームのIDに紐づいた全てのメッセージ（@room.messages）を@messagesとして定義 / ユーザー情報も欲しいから取得（includes）
  end

  def create
    @room = Room.find(params[:room_id])
    # どのルームのお話なのかを特定(room_id)し変数に代入
    @message = @room.messages.new(message_params)
    # チャットルームのIDに紐づいたメッセージのインスタンスを生成 / どのユーザーがどんな内容のメッセージを送ったのかを受け取っている
    if @message.save
      redirect_to  room_messages_path(@room)
      # 参加しているチャットルームに投稿したメッセージの一覧画面
    else
      @messages = @room.messages.includes(:user)
      render :index
    end
  end

  private
  def message_params
    params.require(:message).permit(:content).merge(user_id: current_user.id)
    #messagesテーブルへcontentを保存するように定義/ログインしているユーザーのIDも受け取れるように定義
  end
end
