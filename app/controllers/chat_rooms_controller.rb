class ChatRoomsController < ApplicationController
  before_action :authenticate_user!
  def index
    @chat_rooms = ChatRoom.all
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = ChatRoom.new(chat_room_params)
    if @chat_room.save
      redirect_to chat_rooms_path
    else
      render :new
    end
  end

  def show
    @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
  end
end
