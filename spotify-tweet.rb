#!/usr/bin/env ruby

require 'twitter'
require './spotify-tweet-data.rb'

curr_track = eval `/usr/bin/osascript spotify-now-playing.scpt`

Twitter.configure do |config|
  config.consumer_key = ENV['consumer_key']
  config.consumer_secret = ENV['consumer_secret']
  config.oauth_token = ENV['oauth_token']
  config.oauth_token_secret = ENV['oauth_token_secret']
end

## Twitter throws an Exception with duplicate statuses so we can just keep posting the song info
##  and it won't actually post a new Tweet until it changes (how cool is that?!)
begin
  Twitter.update(%(NOW PLAYING: "#{curr_track[:track]}" by #{curr_track[:artist]} on #{curr_track[:album]}))
rescue Exception => e
  puts e.message
end
