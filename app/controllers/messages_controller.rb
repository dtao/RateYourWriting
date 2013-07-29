class MessagesController < ApplicationController
  def index
    @messages = current_user.messages.order(:id => :desc)
    @sent_messages = current_user.sent_messages.order(:id => :desc)
  end

  def show
    @message = Message.find(params[:id])
  end

  def create
    message = Message.create!(message_params)
    alert "Sent message to #{message.recipient.name}.", :success
    redirect_to message
  end

  private

  def message_params
    params.require(:message).permit(:recipient_id, :subject, :body).merge(:sender => current_user)
  end
end
