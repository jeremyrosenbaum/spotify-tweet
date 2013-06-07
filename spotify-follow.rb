#!/usr/bin/env ruby

require 'tweetstream'
require './spotify-follow-data.rb'

TweetStream.configure do |config|
  config.consumer_key = ENV['consumer_key']
  config.consumer_secret = ENV['consumer_secret']
  config.oauth_token = ENV['oauth_token']
  config.oauth_token_secret = ENV['oauth_token_secret']
  config.auth_method = :oauth
end

client = TweetStream::Client.new
#client = TweetStream::Daemon.new

client.userstream do |status|
  #track = status.text.sub(/^NOW PLAYING: /, '').sub(/by.*$/, '')
  #artist = status.text.sub(/^NOW PLAYING:.*by /, '').sub(/,.*$/, '') 
  uri = status.text.sub(/^NOW PLAYING:.*, /, 'spotify:track:')
  #`/usr/bin/osascript spotify-play-track.scpt #{uri}`
  puts status.text.sub(/, #{uri.split(':').last}/, '')
end

