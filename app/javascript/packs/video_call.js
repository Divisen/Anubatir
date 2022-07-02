window.joinRoom = async function(room, token){

  const Video = Twilio.Video;

  const localTracks = await Video.createLocalTracks({
  audio: true,
  video: { height: 1080, frameRate: 24, width: 1980 },
  });
  try {
  room = await Video.connect(token, {
    name: room,
    tracks: localTracks,
    bandwidthProfile: {
      video: {
      mode: 'collaboration',
      maxTracks: 10,
      dominantSpeakerPriority: 'high',
      renderDimensions: {
        high: {height:1080, width:1980},
        standard: {height:720, width:1280},
        low: {height:176, width:144}
        }
      }
    },
    dominantSpeaker: true,
    maxAudioBitrate: 16000,
    preferredVideoCodecs: [{ codec: 'VP8', simulcast: true }],
    networkQuality: {local:1, remote: 4}
  });
  } catch (error) {
  console.log(error);
  }

  // display your own video element in DOM
  // localParticipants are handled differently
  // you don't need to fetch your own video/audio streams from the server
  const localMediaContainer = document.getElementById("local-video");
  localTracks.forEach((localTrack) => {
    localMediaContainer.appendChild(localTrack.attach());
  });

  // display video/audio of other participants who have already joined
  room.participants.forEach(onParticipantConnected);

  // subscribe to new participant joining event so we can display their video/audio
  room.on("participantConnected", onParticipantConnected);
  room.on("participantDisconnected", onParticipantDisconnected);
  $("#call-end-btn").removeClass("d-none");
  $("#call-mute-btn").removeClass("d-none");
  $("#video-disable-btn").removeClass("d-none");
  $("#screen-share-btn").removeClass("d-none");

  $("#call-end-btn").on("click",function() {
    onLeaveButtonClick(room);
  })
  $("#call-mute-btn").on("click",function() {
    onMuteAudioButton(room);
  })
  $("#call-unmute-btn").on("click",function() {
    onUnMuteAudioButton(room);
  })
  $("#video-disable-btn").on("click",function() {
    onDisableVideoButton(room);
  })
  $("#video-enable-btn").on("click",function() {
    onEnableVideoButton(room);
  })
  $("#screen-share-btn").on("click",function() {
    onScreenShareButton(room);
  })
};

window.onParticipantConnected = function(participant){
  var remote_div = document.getElementById('remote-video');
  const participantDiv = document.createElement('div');
  participantDiv.id = participant.sid;

  // when a remote participant joins, add their audio and video to the DOM
  const trackSubscribed = (track) => {
    participantDiv.appendChild(track.attach());
  };
  participant.on("trackSubscribed", trackSubscribed);
  participant.on("trackPublished", (publication) =>{
    $("#remote-video video:first").addClass("d-none");
  } );

  participant.on("trackUnpublished", (publication) =>{
    $("#remote-video video:first").removeClass("d-none");
  } );

  participant.tracks.forEach((publication) => {
    if (publication.isSubscribed) {
    trackSubscribed(publication.track);
    }
  });

  remote_div.appendChild(participantDiv);

  const trackUnsubscribed = (track) => {
    track.detach().forEach((element) => element.remove());
  };
  participant.on('trackDisabled', track => {
    if (track.kind == "video"){
      $("#remote-video video:first").addClass("d-none");
    }
  });
  participant.on('trackEnabled', track => {
    if (track.kind == "video"){
      $("#remote-video video:first").removeClass("d-none");
    }
  });
  participant.on("trackUnsubscribed", trackUnsubscribed);
};

window.onParticipantDisconnected = function(participant){
  const participantDiv = document.getElementById(participant.sid);
  participantDiv.parentNode.removeChild(participantDiv);
};

window.onLeaveButtonClick = function(room){
  room.localParticipant.tracks.forEach((publication) => {
    const track = publication.track;
    // stop releases the media element from the browser control
    // which is useful to turn off the camera light, etc.
    track.stop();
    const elements = track.detach();
    elements.forEach((element) => element.remove());

  });
  room.disconnect();
  window.location = '/';
};

window.onMuteAudioButton = function(room){
  room.localParticipant.audioTracks.forEach(function(audioTrack) {
    audioTrack.track.disable();
  });
  $("#call-mute-btn").addClass("d-none");
  $("#call-unmute-btn").removeClass("d-none");
};

window.onUnMuteAudioButton = function(room){
  room.localParticipant.audioTracks.forEach(function(audioTrack) {
    audioTrack.track.enable();
  });
  $("#call-mute-btn").removeClass("d-none");
  $("#call-unmute-btn").addClass("d-none");
};

window.onDisableVideoButton = function(room){
  room.localParticipant.videoTracks.forEach(function(videoTrack) {
    videoTrack.track.disable();
  });
  $("#video-disable-btn").addClass("d-none");
  $("#video-enable-btn").removeClass("d-none");
};

window.onEnableVideoButton = function(room){
  room.localParticipant.videoTracks.forEach(function(videoTrack) {
    videoTrack.track.enable();
  });
  $("#video-disable-btn").removeClass("d-none");
  $("#video-enable-btn").addClass("d-none");
};

window.createScreenTrack= function(height, width) {
  const Video = Twilio.Video;
  if (typeof navigator === 'undefined'
    || !navigator.mediaDevices
    || !navigator.mediaDevices.getDisplayMedia) {
    return Promise.reject(new Error('getDisplayMedia is not supported'));
  }
  return navigator.mediaDevices.getDisplayMedia({
    video: {
      height: height,
      width: width
    }
  }).then(function(stream) {
    return new Video.LocalVideoTrack(stream.getVideoTracks()[0]);
  });
}

window.PublishedTracks =function( room, track){
  room.localParticipant.publishTrack(track);
  let localMediaContainer = document.getElementById("local-video");
  localMediaContainer.appendChild(track.attach());
  $("#stop-screen-share-btn").on("click",function() {
    onStopScreenShareButton(room,track);
  })
}

window.StopTracks =function( room, track){
  room.localParticipant.unpublishTrack(track);
  track.stop();
  track = null;
  let localMediaContainer = document.getElementById("local-video");
  localMediaContainer.removeChild(localMediaContainer.lastChild);
}

window.onScreenShareButton = async function(room){
  let screenTrack = await createScreenTrack(700, 700);
  PublishedTracks( room, screenTrack );
  $("#screen-share-btn").addClass("d-none");
  $("#stop-screen-share-btn").removeClass("d-none");
}
window.onStopScreenShareButton = function(room,track){
  StopTracks( room, track );
  $("#screen-share-btn").removeClass("d-none");
  $("#stop-screen-share-btn").addClass("d-none");
}
