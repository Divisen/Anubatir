class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  def index
    @skip_footer = true
    @skip_navbar = true
    @participants = Participant.where(user_id: current_user.id)
    @chatrooms = @participants.map do |participant|
      participant.chatroom
    end
  end

  def show
    @message = Message.new
    @chatroom = Chatroom.find(params[:id])
    @skip_navbar = true
    @skip_footer = true
  end
end
