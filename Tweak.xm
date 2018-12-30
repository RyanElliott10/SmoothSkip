// To get rid of Genius - will be removed once completed, it's
// just aggravating me a lot right now
%hook SPTGeniusService
-(_Bool)isEnabled {
	return false;
}
%end

@interface SPTStatefulPlayerTrackPosition
@property(nonatomic) float playbackSpeed;
@property(nonatomic) double duration;
@property(retain, nonatomic) SPTPlayerState *playerState;
@property(nonatomic) double seekedPosition;
@property(nonatomic) double positionTimestamp;
@property(nonatomic) double positionBase;
@property(readonly, nonatomic) double trackLength;
- (double)deriveDuration;
- (id)initWithPlayer:(id)arg1 queue:(id)arg2;
@end

@interface SPTPlayerTrack
@property(nonatomic) double fadeOverlap;
@end

@interface SPTStatefulPlayerQueue
- (void)skipToPreviousTrack;
- (void)skipToNextTrack;
@property(readonly, nonatomic) SPTPlayerTrack *playingTrack;
@end

@interface SPTStatefulPlayer
@property(retain, nonatomic) SPTStatefulPlayerQueue *queue;
@property(retain, nonatomic) SPTStatefulPlayerTrackPosition *trackPosition;
- (void)seekTo:(double)arg1;
- (double)duration;
- (double)position;
@end


%hook SPTStatefulPlayer
// Controls whether the track can be skipped
- (void)skipToNextTrack
{
	// %orig;
	// Get an instance of SPTStatefulPlayerTrackPosition
	// SPTStatefulPlayerTrackPosition *_statefulPlayerTrackPosition = [self trackPosition];
	// Get an instance of SPTPlayerState
	// SPTPlayerState *_playerState = [_statefulPlayerTrackPosition playerState];
	// Get an instance of SPTStatefulPlayerQueue
	// SPTStatefulPlayerQueue *_statefulPlayerQueue = [self queue];
	// Get an instance of SPTPlayerTrack
	// SPTPlayerTrack *_playerTrack = _statefulPlayerQueue.playingTrack;

	// SPTStatefulPlayer class derives its duration from SPTStatefulPlayerTrackPosition
	// double _duration = [self duration];

	// It appears SPTStatefulPlayerTrackPosition uses SPTPlayerState's duration in its deriveDuration
	// method. However, this doesn't actually change the duration of the item. Apparently, that would
	// be far too convenient
	// _playerState.duration = [self position];

	// It appears it derives the duration from SPTStatefulPlayerQueue's information

	// NSLog(@"PreviousStatefulPlayerTrackPositionDuration: %f", [_statefulPlayerTrackPosition duration]);
	// NSLog(@"StatefulPlayerPosition: %f", [self position]);
	//
	// // Change StatefulPlayerTrackPosition's duration
	// _statefulPlayerTrackPosition.duration = [self position] + 6;
	// NSLog(@"IntermediateStatefulPlayerTrackPositionDuration: %f", [_statefulPlayerTrackPosition duration]);
	// [self seekTo:[_statefulPlayerTrackPosition duration]];
	//
	// _statefulPlayerTrackPosition.duration = [self position];
	// NSLog(@"IntermediateStatefulPlayerTrackPositionDeriveDuration: %f", [_statefulPlayerTrackPosition deriveDuration]);

	// Set the track position to contain the new data
	// [self setTrackPosition:_statefulPlayerTrackPosition];
	// [NSThread sleepForTimeInterval:12.0f];


	if ([self position] < [self duration]-8)
	{
		[self seekTo:[self duration]-8];
	} else
	{
		%orig;
	}

	// NSLog(@"CurrentStatefulPlayerTrackPositionDuration: %f", [_statefulPlayerTrackPosition duration]);
	// NSLog(@"selfDuration: %f", [self duration]);
}
%end


// @interface SPTPlayerState
// @property(nonatomic) double duration;
// @property(nonatomic, getter=isPaused) _Bool paused;
// @property(nonatomic) double positionAsOfTimestamp;
// @end
//
// %hook SPTPlayerState
// - (double)duration
// {
// 	// NSLog(@"%@",[NSThread callStackSymbols]);
// 	// NSLog(@"%@",[NSThread currentThread]);
// 	return %orig;
// }
// %end
//
//
// @interface SPTPlayerImpl
// @end
//
// %hook SPTPlayerImpl
// - (id)skipToNextTrackWithOptions:(id)arg1
// {
// 	NSLog(@"%@",[NSThread callStackSymbols]);
// 	return %orig(arg1);
// }
// %end
