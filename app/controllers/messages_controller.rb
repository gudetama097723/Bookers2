class MessagesController < ApplicationController

  def create
  @room = Room.finde(params[:room_id])
  @message = @room.messages.build(message_params)
  @message.user = current_user

  if @message.sabe
    redirect_to room_path(@room)
  else
    render "rooms/show"
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
