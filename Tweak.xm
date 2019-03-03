//
//  Tweak.xm
//  SmoothSkip
//
//  Created by Ryan Elliott on 12/17/18.
//  Copyright © 2018 Ryan Elliott. All rights reserved.
//

#import "Tweak.h"

// IMPLEMENTATION IDEA: On press of skip, change the song's duration in the dict. Then, add an if somewhere in a controller that checks 
// against the modified dictionary. If the position is within 8 of the new duration (pulled from the dict), call the method
// that is normally called when the song naturally skips

// PLAN:
// 1. Clean up existing code and remove unneeded methods (DONE)
// 2. Find the method that is called when the song naturally skips
// 3. Add the conditional that checks against the dictionary
//    3a. This might be difficult because it might not have the right variables. To solve this, just add in variables in the 
// 		  header and initalize them in the init method
// 4. Pull the user's crossfade duration
//    4a. This might end up in the sections setting of the tweak
// 5. Test

// Changed the data in here persists through a single state. As soon as a user
// changes the state (i.e. pauses), the data is reset, which is actually fine.
%hook SPTPlayerImpl
- (SPTask *)skipToNextTrackWithOptions:(id)arg1
{
	// Get an instance of SPTPlayerState
	SPTPlayerState *_playerStateInstance = [self state];
	SPTPlayerTrack *_playerTrackInstance = [_playerStateInstance track];
	double _position = [_playerStateInstance position];
	double _initDuration = [_playerStateInstance duration];

	// Set the new duration value for the _playerTrackInstance to be accessed elsewhere
	// This dict stores duration in seconds
	NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
	[newDict addEntriesFromDictionary:[_playerTrackInstance metadata]];
	[newDict setObject:@(_initDuration-2) forKey:@"duration"];
	[_playerTrackInstance setMetadata:newDict];

	// Set the new duration in the _playerStateInstance to be accessed elsewhere
	[_playerStateInstance setDuration:(double)[[_playerTrackInstance metadata][@"duration"] floatValue]];
	
	return (_position < _initDuration - 12 ? nil : %orig);
}
%end
