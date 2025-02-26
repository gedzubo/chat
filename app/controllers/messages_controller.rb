class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat_room
  def create
    @message = @chat_room.messages.new(message_params)
    @message.user = current_user
    @message.save

    render json: {}, status: :no_content
  end

  private

  def set_chat_room
    @chat_room = ChatRoom.find(params[:chat_room_id])
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
