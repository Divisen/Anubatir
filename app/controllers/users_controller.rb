class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def click
    @user = User.find(params[:id])
    @chatroom = Chatroom.new
    @chatroom_name = get_name(@user, current_user)
    @single_chatroom = Chatroom.where(name: @chatroom_name).first || Chatroom.create_private_chatroom([@user, current_user], @chatroom_name)
    redirect_to chatroom_path(@single_chatroom)
  end

  def clickvideo
    @user = User.find(params[:id])
    @video_chat = VideoChat.new
    @client = Twilio::REST::Client.new(ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN'])
    unless @video_chat.room_sid.present?
      @video_chat_name = get_videoname(@user, current_user)
      @single_video_chat = VideoChat.create_private_video_chat([@user, current_user], @video_chat_name)
      twilio_video_chat = @client.video.rooms.create(type: 'peer-to-peer', unique_name: @video_chat_name)
      @video_chat.update(room_sid: twilio_video_chat.sid)
    end
    identity = (0...5).map { ('a'..'z').to_a[rand(26)] }.join
    @video_chat.unique_name = @video_chat_name
    @token = Twilio::JWT::AccessToken.new(ENV['ACCOUNT_SID'], ENV['API_KEY_SID'],ENV['API_KEY_SECRET'], identity: identity)

    grant = Twilio::JWT::AccessToken::VideoGrant.new
    grant.room = @video_chat_name

    @token.add_grant grant
    @token = @token.to_jwt

    redirect_to video_chat_path(@single_video_chat)
  end

  private

  def get_name(user1, user2)
    user = [user1, user2].sort
    "Convo between: #{user[0].username} & #{user[1].username}"
  end

  def get_videoname(user1, user2)
    user = [user1, user2].sort
    "Video between: #{user[0].username} & #{user[1].username} #{(0...5).map { ('a'..'z').to_a[rand(26)] }.join}"
  end
end
