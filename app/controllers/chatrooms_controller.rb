class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  def index
    @chatrooms = Chatroom.all
  end

  def show
    @message = Message.new
    @chatroom = Chatroom.find(params[:id])
  end
end
