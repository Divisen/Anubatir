class VideoChatsController < ApplicationController
  def index
    @video_chats = VideoChat.all
  end

  def show
    @skip_footer = true
    @video_chat = VideoChat.find(params[:id])
    @client = Twilio::REST::Client.new(ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN'])
    unless @video_chat.room_sid.present?
      twilio_video_chat = @client.video.rooms.create(type: 'peer-to-peer', unique_name: @video_chat.unique_name)
      @video_chat.update(room_sid: twilio_video_chat.sid)
    end
    identity = (0...5).map { ('a'..'z').to_a[rand(26)] }.join
    @video_chat_name = @video_chat.unique_name

    @token = Twilio::JWT::AccessToken.new(ENV['ACCOUNT_SID'], ENV['API_KEY_SID'],ENV['API_KEY_SECRET'], identity: identity)

    grant = Twilio::JWT::AccessToken::VideoGrant.new
    grant.room = @video_chat_name

    @token.add_grant grant
    @token = @token.to_jwt
  end

  def new
    @video_chat = VideoChat.new
  end

  def create
    @video_chat = VideoChat.new(video_chat_params)
    if @video_chat.save
      redirect_to video_chat_path(@video_chat)
    else
      render :new
    end
  end

  private

  def video_chat_params
    params.require(:video_chat).permit(:name, :room_sid, :unique_name)
  end
end
