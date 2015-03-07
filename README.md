# spotify_tweet
### Listen along with your far-away friends

At one of my previous jobs, we had a tradition of collectively playing music every Friday via [turntable.fm](http://en.wikipedia.org/wiki/Turntable.fm) until it shut down.

To keep some semblance of Music Friday going, I started up a Spotify playlist that anyone could add to and played it on shuffle over some external speakers at HQ.  Our colleagues in the remote office, who always joined us on turntable.fm, were less than enthused.  They could access the playlist, but they couldn't listen to what we were listening to in real time.

So, I hacked together a quick, but effective, solution using Ruby, Applescript and Twitter so that the remote folks could listen along.

Obviously, due to the Applescript piece, this only works on Mac.

## Usage
A Twitter application is required.  The broadcaster will need credentials with write permissions and the listeners will need credentials with read-only permissions.

The Spotify application is required to be installed for both broadcaster and listeners.  No subscription is required for any party, but ads may interrupt the music for users with non-paid accounts.

Both broadcaster and listeners will need to create credentials files (spotify-tweet-data.rb and spotify-follow-data.rb, respectively) in the same directory as the scripts that set following environment variable with Twitter application creds:

* consumer_key
* consumer_secret
* oauth_token
* oauth_token_secret

The broadcaster runs 'spotify-tweet.rb' which will continuously poll for what is playing and post a message to the Twitter application account that includes the Spotify URI for the song when a new song starts.

The listeners run 'spotify-follow.rb' which will monitor the Twitter application account and play the songs posted by the broadcaster on the listeners' workstations as it receives them.
