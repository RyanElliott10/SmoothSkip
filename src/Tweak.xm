// To get rid of Genius - will be removed once completed, it's
// just aggravating me a lot right now
// %hook SPTGeniusService
// -(_Bool)isEnabled {
// 	return false;
// }
// %end


@interface SPTPlayerTrack
@property(copy, nonatomic) NSDictionary *metadata;
@end

@interface SPTPlayerState
@property(readonly, nonatomic) double position;
@property(nonatomic) double duration;
@property(retain, nonatomic) SPTPlayerTrack *track;
@end

@interface SPTPlayerImpl
@property(readonly, copy, nonatomic) SPTPlayerState *state;
- (id)seekTo:(double)arg1;
@end


%hook SPTPlayerImpl
- (id)skipToNextTrackWithOptions:(id)arg1
{
	// Get an instance of SPTPlayerState
	SPTPlayerState *_lastState = [self state];

	// Get an instance of SPTPlayerTrack
	SPTPlayerTrack *_playerTrack = [_lastState track];
	NSLog(@"init metadata: %p", _playerTrack.metadata);

	// Create new NSMutableDictionary since NSDictionary objects are immutable
	NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
	// Copy metadata values to new dictionary
	[newDict addEntriesFromDictionary:_playerTrack.metadata];

	// Grab the current position of the track
	double _position = [_lastState position];
	double _initDuration = [_lastState duration];
	// Set the new track duration to the position + 8 seconds
	NSNumber *_duration = [NSNumber numberWithFloat:(_position*10000)+8000];
	NSString *_newDuration = [_duration stringValue];

	// Change the duration key's value
	[newDict setObject:_newDuration forKey:@"duration"];
	// Set the old metadata dictionary to the new dictionary, except as NSDictionary object
	_playerTrack.metadata = [[newDict copy] autorelease];

	NSLog(@"new dictionary: %p", newDict);
	NSLog(@"SPTPlayerTrack metadata dictionary: %p", [_playerTrack metadata]);
	NSLog(@"position: %f", _position);
	NSLog(@"duration: %@", [_duration stringValue]);
	NSLog(@"Here's the skip track stack");
	NSLog(@"%@",[NSThread callStackSymbols]);

	if (_position < _initDuration-6)
	{
		[self seekTo:[_lastState duration]-6];
		return nil;
	} else
	{
		return %orig(arg1);
	}
}

- (id)pause:(id)arg1
{
	// Get an instance of SPTPlayerState
	SPTPlayerState *_lastState = [self state];
	// Get an instance of SPTPlayerTrack
	SPTPlayerTrack *_playerTrack = [_lastState track];

	NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
	// Copy metadata values to new dictionary
	[newDict addEntriesFromDictionary:_playerTrack.metadata];
	[newDict setObject:@"10" forKey:@"duration"];

	NSLog(@"init pause current metadata: %p", _playerTrack.metadata);
	_playerTrack.metadata = [[newDict copy] autorelease];
	NSLog(@"pause metadata: %p", _playerTrack.metadata);
	return %orig(arg1);
}
%end


@interface SPTNowPlayingTrackMetadataQueue
@property(readonly, nonatomic) SPTPlayerTrack *currentMetadata;
@end

%hook SPTNowPlayingTrackMetadataQueue
- (void)skipToNextTrack
{
	NSLog(@"queue current metadata: %p", [[self currentMetadata] metadata]);
	%orig;
}

- (id)setQueue:(id)arg1
{
	NSLog(@"HERE, RYAN");
	return %orig(arg1);
}
%end
