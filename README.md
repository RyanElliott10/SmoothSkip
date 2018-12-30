# SmoothSkip
A tweak to smooth the transition between skipped songs in Spotify.

Please note, this tweak is currently in development. Right now, SmoothSkip simply hooks into the SPTStatefulPlayer class and adjusts the `- (void)skipToNextTrack` method. While this may somewhat work, it is not the functionality I intended for when I began this project.

In the future, I plan on adjusting the duration of the current track such that it is a set number of seconds longer than the current position. In doing this, I will (hopefully) force Spotify to invoke its own method (which I have not found) and smoothen the transition even more.

Once I manage to find the method that controls the duration of the track (I haven't had much success with stack tracing since everything is <redacted> for some reason), I should be able to easily implement the tweak as I desired.
