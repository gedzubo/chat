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
    @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:name)
  end
end
