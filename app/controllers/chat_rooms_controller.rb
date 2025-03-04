class ChatRoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat_room, only: [ :join, :leave ]
  # Add pagination
  def index
    @chat_rooms = ChatRoom.includes(:users).order("created_at DESC").page params[:page]
  end

  def new
    @chat_room = ChatRoom.new
  end

  def create
    @chat_room = ChatRoom.new(chat_room_params)
    @chat_room.user = current_user

    respond_to do |format|
      if @chat_room.save
        format.turbo_stream
      else
        format.html { render :new }
      end
    end
  end

  def show
    @chat_room = current_user.chat_rooms.includes(:messages).find(params[:id])
  end

  def join
    @chat_room.chat_room_members.create(user: current_user)

    redirect_to chat_room_path(@chat_room)
  end

  def leave
    @chat_room.chat_room_members.where(user: current_user).destroy_all

    redirect_to chat_rooms_path
  end

  private

  def set_chat_room
    @chat_room = ChatRoom.find(params[:id])
  end

  def chat_room_params
    params.require(:chat_room).permit(:name)
  end
end
