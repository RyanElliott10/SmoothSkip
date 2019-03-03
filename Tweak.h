//
//  Tweak.h
//  SmoothSkip
//
//  Created by Ryan Elliott on 12/17/18.
//  Copyright © 2018 Ryan Elliott. All rights reserved.
//

// List of classes with skipToNextTrack*:
// SPTStatefulPlayer
// SPTPlayerState
// SPTNowPlayingTrackMetadataQueue
// SPTPlayerImpl

@interface SPTask
@end

@interface SPTPlayerTrack
@property(copy, nonatomic) NSDictionary *metadata;

- (id)artistName;
@end

@interface SPTPlayerState
@property(readonly, nonatomic) NSDictionary *dictionary; // @synthesize dictionary=_dictionary;
@property(readonly, nonatomic) NSDictionary *pageMetadata; // @synthesize pageMetadata=_pageMetadata;
@property(readonly, nonatomic) NSDictionary *contextMetadata; // @synthesize contextMetadata=_contextMetadata;

@property(readonly, nonatomic) double position;
@property(nonatomic) double duration;
@property(retain, nonatomic) SPTPlayerTrack *track;
@property(nonatomic) double playbackSpeed;
@end

@interface SPTPlayerImpl
@property(readonly, copy, nonatomic) SPTPlayerState *state;

- (SPTask *)skipToNextTrackWithOptions:(id)arg1;
@end

@interface SPTNowPlayingTrackMetadataQueue
@property(readonly, nonatomic) SPTPlayerTrack *playingMetadata;
@property(readonly, nonatomic) SPTPlayerTrack *currentMetadata;

- (void)skipToNextTrack;
@end



@interface SPTNowPlayingInformationUnitViewModel

- (void)navigateToCurrentArtist;
- (id)getMainArtistNameFromTrackMetadata:(id)arg1;
- (id)getArtistsFromTrackMetadata:(id)arg1;
@end