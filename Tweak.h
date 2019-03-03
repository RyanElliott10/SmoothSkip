//
//  Tweak.h
//  SmoothSkip
//
//  Created by Ryan Elliott on 12/17/18.
//  Copyright © 2018 Ryan Elliott. All rights reserved.
//

@interface SPTPlayerState
@property(nonatomic) double duration;
@end


@interface SPTPlayerImpl
@property(readonly, copy, nonatomic) SPTPlayerState *state;
- (id)seekTo:(double)arg1;
@end
