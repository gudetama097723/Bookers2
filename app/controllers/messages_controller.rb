class MessagesController < ApplicationController

  def create
  @room = Room.find(params[:room_id])
  @message = @room.messages.build(message_params)
  @message.user = Current.user

  if @message.save
    redirect_to room_path(@room), status: :see_other
  else
    @messages = @room.messages
    render "rooms/show", status: :unprocessable_entity
  end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
