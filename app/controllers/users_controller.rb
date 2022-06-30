class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def click
    @user = User.find(params[:id])
    @chatroom = Chatroom.new
    @chatroom_name = get_name(@user)
    @single_chatroom = Chatroom.where(name: @chatroom_name).first || Chatroom.create_private_chatroom([@user, current_user], @chatroom_name)
    redirect_to chatroom_path(@single_chatroom)
  end

  private

  def get_name(user)
    "#{user.username}"
  end
end
