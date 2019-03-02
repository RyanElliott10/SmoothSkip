//
//  Tweak.h
//  SmoothSkip
//
//  Created by Ryan Elliott on 12/17/18.
//  Copyright © 2018 Ryan Elliott. All rights reserved.
//

@interface SPTNowPlayingTrackMetadataQueue
@property(readonly, nonatomic) SPTPlayerTrack *playingMetadata;
@property(readonly, nonatomic) SPTPlayerTrack *currentMetadata;

- (void)playerDidFinishUpdating:(id)arg1;
- (void)playerDidUpdatePlaybackControls:(id)arg1;
- (void)playerDidUpdateTrackPosition:(id)arg1;
- (void)willSkipToNext;
- (void)skipToNextTrack;
@end
