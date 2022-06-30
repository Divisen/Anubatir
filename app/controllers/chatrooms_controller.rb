class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  def index
   @user = current_user
  end

  def show
    @message = Message.new
    @chatroom = Chatroom.find(params[:id])
  end
end
