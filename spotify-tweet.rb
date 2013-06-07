#!/usr/bin/env ruby

gem 'json', '~> 1.7.7'
require 'twitter'
require './spotify-tweet-data.rb'

@now_playing = ""

while 1
  curr_track = eval `/usr/bin/osascript spotify-now-playing.scpt`
  unless @now_playing == curr_track  
    track = curr_track[:track]
    artist = curr_track[:artist]
    uri = curr_track[:uri].sub(/^spotify:track:/, '')
    data_length = track.length + artist.length + uri.length 

    if data_length > 119            # Characters available after non-variable tweet text
       overage = data_length - 123  # Since we subtract overage from track.length for the slice below, we're adding another -1 to account for 0-indexed, and another -3 to replace with '...'
       track.slice!(0, track.length - overage)
       track << '...'
    end

    tweet = %(NOW PLAYING: "#{track}" by #{artist}, #{uri})

    Twitter.configure do |config|
      config.consumer_key = ENV['consumer_key']
      config.consumer_secret = ENV['consumer_secret']
      config.oauth_token = ENV['oauth_token']
      config.oauth_token_secret = ENV['oauth_token_secret']
    end

    ## Twitter throws an Exception with duplicate statuses so we can just keep posting the song info
    ##  and it won't actually post a new Tweet until it changes (how cool is that?!)
    begin
      Twitter.update(tweet)
      puts "UPDATED: #{tweet}"
      @now_playing = curr_track
    rescue Exception => e
      puts "ERROR: #{e.message}"
    end
  end
  sleep 5
end
