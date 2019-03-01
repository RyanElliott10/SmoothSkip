#import "Tweak.h"

// IDEA: When the user skips, call the new setCustomDuration in SPTPlayerState to change the duration

%hook SPTPlayerState
- (double)getDuration
{
	return self.duration;
}

%new
- (SPTPlayerTrack *)setCustomDuration:(double)newDuration
{
	// Hook the duration ivar and change its value
	NSLog(@"RYANLOG old duration: %f", [self duration]);
	[self setDuration:newDuration];
	NSLog(@"RYANLOG new duration: %f", [self duration]);
	return [self track];
}
%end


%hook SPTPlayerImpl

- (id)seekTo:(double)arg1 options:(id)arg2
{
	NSLog(@"RYANLOG seekTo:(double)arg1 options:(id)arg2: %f %@", arg1, arg2);
	return %orig(arg1, arg2);
}

- (id)seekTo:(double)arg1
{
	NSLog(@"RYANLOG seekTo:(double)arg1: %f", arg1);
	return %orig(arg1);
}

- (SPTask *)skipToNextTrackWithOptions:(id)arg1
{
	// Get an instance of SPTPlayerState
	SPTPlayerState *_playerStateInstance = [self state];
	// SPTPlayerTrack *_playerTrackInstance = [_playerStateInstance track];
	double _initDuration = [_playerStateInstance duration];

	return [self seekTo:_initDuration-8];
	// return nil;

	// NSLog(@"RYANLOG metadata: %@", [_playerTrackInstance metadata][@"duration"]);

	// NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
	// NSDictionary *oldDict = (NSDictionary *)[_playerTrackInstance metadata];
	// [newDict addEntriesFromDictionary:oldDict];
	// [newDict setObject:@(1000) forKey:@"duration"];
	// [_playerTrackInstance setMetadata:newDict];
	// [newDict release];

	// NSLog(@"RYANLOG metadata: %@", [_playerTrackInstance metadata][@"duration"]);

	// // SPTask *tmp = %orig(arg1);
	// // NSLog(@"RYANLOG %@", [tmp superclass]);
	// // return tmp;

	// double _position = [_playerStateInstance position];
	// double _initDuration = [_playerStateInstance duration];

	// if (_position < _initDuration-8) {
	// 	// HBLogInfo(@"RYANLOG %@", [_playerStateInstance setCustomDuration:_position-8]);
	// 	return [_playerStateInstance setCustomDuration:_position-8];
	// } else {
	// 	NSLog(@"RYANLOG %@", %orig(arg1));
	// 	return %orig(arg1);
	// }
}
%end
