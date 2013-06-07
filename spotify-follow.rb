#!/usr/bin/env ruby

require 'tweetstream'
require 'terminal-notifier'
require './spotify-follow-data.rb'

TweetStream.configure do |config|
  config.consumer_key = ENV['consumer_key']
  config.consumer_secret = ENV['consumer_secret']
  config.oauth_token = ENV['oauth_token']
  config.oauth_token_secret = ENV['oauth_token_secret']
  config.auth_method = :oauth
end

client = TweetStream::Client.new

client.userstream do |status|
  uri = status.text.sub(/^NOW PLAYING:.*, /, 'spotify:track:')
  `/usr/bin/osascript spotify-play-track.scpt #{uri}`
  notice = status.text.sub(/, #{uri.split(':').last}/, '')
  TerminalNotifier.notify(notice)
end

