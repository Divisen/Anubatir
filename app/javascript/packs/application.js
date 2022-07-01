// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require jquery3
//= require jquery_ujs
//= require_tree .

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
require("jquery")
import $ from 'jquery';
window.jQuery = $; window.$ = $;

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "controllers";
import "bootstrap";
import "cocoon";


// Video Call
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

  const localMediaContainer = document.getElementById("local-video");
  localTracks.forEach((localTrack) => {
    localMediaContainer.appendChild(localTrack.attach());
  });

  // display video/audio of other participants who have already joined
  room.participants.forEach(onParticipantConnected);

  room.on("participantConnected", onParticipantConnected);
  room.on("participantDisconnected", onParticipantDisconnected);
 $("#call-end-btn").removeClass("d-none");
 $("#call-end-btn").on("click",function() {
   onLeaveButtonClick(room);
 })

};

window.onParticipantConnected = function(participant){
  var remote_div = document.getElementById('remote-video');
  const participantDiv = document.createElement('div');
  participantDiv.id = participant.sid;

  const trackSubscribed = (track) => {
    participantDiv.appendChild(track.attach());
  };
  participant.on("trackSubscribed", trackSubscribed);

  participant.tracks.forEach((publication) => {
    if (publication.isSubscribed) {
    trackSubscribed(publication.track);
    }
  });

  remote_div.appendChild(participantDiv);

  const trackUnsubscribed = (track) => {
    track.detach().forEach((element) => element.remove());
  };

  participant.on("trackUnsubscribed", trackUnsubscribed);
};

window.onParticipantDisconnected = function(participant){
  const participantDiv = document.getElementById(participant.sid);
  participantDiv.parentNode.removeChild(participantDiv);
};

window.onLeaveButtonClick = function(room){
 room.localParticipant.tracks.forEach((publication) => {
    const track = publication.track;
    track.stop();
    const elements = track.detach();
    elements.forEach((element) => element.remove());

  });
  room.disconnect();
  window.location = '/';
};
