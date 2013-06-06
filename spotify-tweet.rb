#!/usr/bin/env ruby

require 'twitter'
require './spotify-tweet-data.rb'

curr_track = eval `/usr/bin/osascript spotify-now-playing.scpt`

track = curr_track[:track]
artist = curr_track[:artist]
uri = curr_track[:uri]
data_length = track.length + artist.length + uri.length 

if data_length > 119            # Characters available after non-variable tweet text
   overage = data_length - 123  # Since we subtract overage from track.length for the slice below, we're adding another -1 to account for 0-indexed, and another -3 to replace with '...'
   track.slice!(0, track.length - overage)
   track << '...'
end

tweet = %(NOW PLAYING: "#{curr_track[:track]}" by #{curr_track[:artist]}, #{curr_track[:uri]})

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
rescue Exception => e
  puts e.message
end
