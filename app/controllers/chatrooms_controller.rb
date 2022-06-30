class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  def index
    @participants = Participant.where(user_id: current_user.id)
  end

  def show
    @message = Message.new
    @chatroom = Chatroom.find(params[:id])
    @skip_navbar = true
    @skip_footer = true
  end
end
