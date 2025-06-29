# MPD

This will work propperly if you:

- have your music on `~/Music/`
- use pulseaudio

If you use mpd, verify that you have the file `.config/mpdnotify.conf`. It 
isn't required that you have it, but that file displays a notification that 
shows you the name, artist and album of the song currently playing if ncmpcpp
is open (it triggers when the song change) and, if there's an image in the folder 
where the music is named as (front | cover | art).(png | jpg | jpeg | gif).

You must create the playlist folder under this directory to correctly save your
playlists.
