@interface SPTPlayerTrack
@property(copy, nonatomic) NSDictionary *metadata;
@end

@interface SPTPlayerState
@property(readonly, nonatomic) double position;
@property(nonatomic) double duration;
@property(retain, nonatomic) SPTPlayerTrack *track;
@property(nonatomic) double playbackSpeed;

// new
- (id)setCustomDuration:(double)newDuration;
@end


@interface SPTPlayerImpl
@property(readonly, copy, nonatomic) SPTPlayerState *state;
- (id)seekTo:(double)arg1 options:(id)arg2;
- (id)seekTo:(double)arg1;
- (id)skipToNextTrackWithOptions:(id)arg1;
@end

@interface SPTask
@property(readonly, copy) NSString *description;
@property(readonly) unsigned long long hash;
@property(readonly) Class superclass;
@end
