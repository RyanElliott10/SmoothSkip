//
//  Tweak.xm
//  SmoothSkip
//
//  Created by Ryan Elliott on 12/17/18.
//  Copyright © 2018 Ryan Elliott. All rights reserved.
//

#import "Tweak.h"

// IDEA: When the user skips, call the new setCustomDuration in SPTPlayerState to change the duration

%hook SPTPlayerImpl
- (id)skipToNextTrackWithOptions:(id)arg1
{
	// Get an instance of SPTPlayerState
	SPTPlayerState *_playerStateInstance = [self state];
	double _initDuration = [_playerStateInstance duration];

	return [self seekTo:_initDuration-8];
}
%end
