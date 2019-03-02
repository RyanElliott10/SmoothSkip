//
//  Tweak.h
//  SmoothSkip
//
//  Created by Ryan Elliott on 12/17/18.
//  Copyright © 2018 Ryan Elliott. All rights reserved.
//

@interface SPTPlayerTrack
@property(copy, nonatomic) NSDictionary *metadata;
@property(readonly, nonatomic) _Bool isShow;
@property(readonly, nonatomic) _Bool isPodcast;
@property(readonly, nonatomic) _Bool isVideo;
@property(nonatomic) double fadeOverlap;
@property(nonatomic) unsigned long long fadeOutDuration;
@property(nonatomic) unsigned long long fadeOutStartTime;
@property(nonatomic) unsigned long long fadeInDuration;
@property(nonatomic) unsigned long long fadeInStartTime;

+ (id)trackWithURI:(id)arg1;
- (id)artistName;
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


@interface SPTStatefulPlayerQueue
@property(readonly, nonatomic) SPTPlayerTrack *playingTrack;
@property(readonly, nonatomic) SPTPlayerTrack *currentTrack;

- (void)skipToNextTrack;
@end


@interface SPTNowPlayingTrackMetadataQueue
@property(readonly, nonatomic) SPTPlayerTrack *playingMetadata;
@property(readonly, nonatomic) SPTPlayerTrack *currentMetadata;

- (void)playerDidFinishUpdating:(id)arg1;
- (void)playerDidUpdatePlaybackControls:(id)arg1;
- (void)playerDidUpdateTrackPosition:(id)arg1;
- (void)willSkipToNext;
- (void)skipToNextTrack;
@end


@interface SPTNowPlayingStateProxy
@property(readonly, nonatomic) SPTNowPlayingTrackMetadataQueue *trackMetadataQueue;

- (void)trackMetadataQueueWillSkipToNextTrack:(id)arg1;
@end


@interface SPTNowPlayingTrackPosition
@property(readonly, nonatomic) double trackLength;

- (id)initWithTrackPositionModel:(id)arg1;
- (void)setTrackLength:(double)arg1;
- (void)scrubToPosition:(double)arg1;
@end


@interface SPTNowPlayingDurationDataSource
@property(readonly, nonatomic) SPTNowPlayingTrackPosition *trackPositionModel; // @synthesize trackPositionModel=_trackPositionModel;

- (double)durationViewCurrentDuration:(id)arg1;
- (double)durationViewCurrentPosition:(id)arg1;
- (SPTNowPlayingTrackPosition *)trackPositionModel;
@end

@interface SPTNowPlayingDurationViewController
@property(nonatomic) _Bool scrubbing; // @synthesize scrubbing=_scrubbing;
@property(readonly, nonatomic) SPTNowPlayingDurationDataSource *dataSource; // @synthesize dataSource=_dataSource;

- (void)carouselViewControllerDidDetectCoverArtTap:(id)arg1;
- (void)nowPlayingTrackPositionDidChange:(id)arg1;
@end


@interface SPTAudioPlayerMediaClockImplementation
@property(nonatomic) long long position; // @synthesize position=_position;

- (double)currentPosition;
@end
