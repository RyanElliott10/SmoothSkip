//
//  Tweak.xm
//  SmoothSkip
//
//  Created by Ryan Elliott on 12/17/18.
//  Copyright © 2018 Ryan Elliott. All rights reserved.
//

#import "Tweak.h"

// IMPLEMENTATION IDEA: On press of skip, change the song's duration in teh dict. Then, add an if somewhere in a controller that checks 
// against the modified dictionary. If the position is within 8 of the new duration (pulled from the dict), call the method
// that is normally called when the song naturally skips

// PLAN:
// 1. Clean up existing code and remove unneeded methods
// 2. Find the method that is called when the song naturally skips
// 3. Add the conditional that checks against the dictionary
//    3a. This might be difficult because it might not have the right variables. To solve this, just add in variables in the 
// 		  header and initalize them in the init method
// 4. Pull the user's crossfade duration
// 	  4a. This might end up in the sections setting of the tweak
// 5. Test

// Changing the duration here does not change the duration everywhere
%hook SPTNowPlayingTrackMetadataQueue

// This calls willSkipToNext and skipToNextTrackWithOptions
// Editing the dictionary in this method persists through other calls
// This makes me think I don't need all the others
- (void)skipToNextTrack
{
	NSLog(@"RYANLOG skipToNextTrack");
	NSLog(@"RYANLOG skipToNextTrack playingMetadata: %@", [[self playingMetadata] metadata][@"duration"]);
	NSLog(@"RYANLOG skipToNextTrack currentMetadata: %@", [[self currentMetadata] metadata][@"duration"]);

	double _duration = (double)[[[self playingMetadata] metadata][@"duration"] floatValue];

	NSLog(@"RYANLOG skipToNextTrack all dict info: %@", [[self playingMetadata] metadata]);

	// Set duration in playingMetadata
	NSMutableDictionary *newDict = [[NSMutableDictionary alloc] init];
	[newDict addEntriesFromDictionary:[[self playingMetadata] metadata]];
	[newDict setObject:@(_duration-20000) forKey:@"duration"];
	[[self playingMetadata] setMetadata:newDict];

	// Set duration in currentMetadata
	newDict = [[NSMutableDictionary alloc] init];
	[newDict addEntriesFromDictionary:[[self currentMetadata] metadata]];
	[newDict setObject:@(_duration-20000) forKey:@"duration"];
	[[self currentMetadata] setMetadata:newDict];

	NSLog(@"RYANLOG skipToNextTrack new playingMetadata duration: %@", [[self playingMetadata] metadata][@"duration"]);
	NSLog(@"RYANLOG skipToNextTrack new currentMetadata duration: %@\n", [[self playingMetadata] metadata][@"duration"]);
	NSLog(@"RYANLOG");

	return %orig;
}
%end
