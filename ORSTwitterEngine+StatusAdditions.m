//
//  ORSTwitterEngine+StatusAdditions.m
//  Twitter Engine
//
//  Created by Nicholas Toumpelis on 12/04/2009.
//  Copyright 2009 Ocean Road Software. All rights reserved.
//
//  Version 0.7

#import "ORSTwitterEngine+StatusAdditions.h"

@implementation ORSTwitterEngine ( StatusAdditions )

#pragma mark Status methods

// Status methods

// returns the most recent statuses from the current user and the people she 
// follows since the given date
- (NSArray *) getFriendsTimelineSince:(NSString *)date {
	NSMutableString *path = [NSMutableString 
		stringWithString:@"statuses/friends_timeline.xml?since="];
	[path appendString:date];
	[path appendString:@"&count=200"];
	NSData *data = [self executeRequestOfType:@"GET" 
									   atPath:path 
								synchronously:synchronously];
	NSXMLNode *node = [self getNodeFromData:data];
	if ([[node name] isEqualToString:@"statuses"]) {
		return [self getAllStatusesFromData:data];
	} else {
		return NULL;
	}
}

// returns x most recent statuses from the current user and the people she 
// follows
- (NSArray *) getFriendsTimelineWithNumberOfStatuses:(NSString *)count {
	NSMutableString *path = [NSMutableString 
		stringWithString:@"statuses/friends_timeline.xml?count="];
	[path appendString:count];
	NSData *data = [self executeRequestOfType:@"GET" 
									   atPath:path 
								synchronously:synchronously];
	NSXMLNode *node = [self getNodeFromData:data];
	if ([[node name] isEqualToString:@"statuses"]) {
		return [self getAllStatusesFromData:data];
	} else {
		return NULL;
	}
}

// returns the 20 most recent statuses from the current user and the people she 
// follows for the given page
- (NSArray *) getFriendsTimelineAtPage:(NSString *)page {
	NSMutableString *path = [NSMutableString 
		stringWithString:@"statuses/friends_timeline.xml?page="];
	[path appendString:page];
	NSData *data = [self executeRequestOfType:@"GET" 
									   atPath:path synchronously:synchronously];
	NSXMLNode *node = [self getNodeFromData:data];
	if ([[node name] isEqualToString:@"statuses"]) {
		return [self getAllStatusesFromData:data];
	} else {
		return NULL;
	}
}

// returns x most recent statuses from the current user
- (NSArray *) getUserTimelineWithNumberOfStatuses:(NSString *)count {
	NSMutableString *path = [NSMutableString 
		stringWithString:@"statuses/user_timeline.xml?count="];
	[path appendString:count];
	NSData *data = [self executeRequestOfType:@"GET" 
									   atPath:path 
								synchronously:synchronously];
	NSXMLNode *node = [self getNodeFromData:data];
	if ([[node name] isEqualToString:@"statuses"]) {
		return [self getAllStatusesFromData:data];
	} else {
		return NULL;
	}
}

// returns the 20 most recent statuses from the current user since the given
// date
- (NSArray *) getUserTimelineSince:(NSString *)date {
	NSMutableString *path = [NSMutableString 
			stringWithString:@"statuses/user_timeline.xml?since="];
	[path appendString:date];
	[path appendString:@"&count=200"];
	NSData *data = [self executeRequestOfType:@"GET" 
									   atPath:path 
								synchronously:synchronously];
	NSXMLNode *node = [self getNodeFromData:data];
	if ([[node name] isEqualToString:@"statuses"]) {
		return [self getAllStatusesFromData:data];
	} else {
		return NULL;
	}
}

// returns the 20 most recent statuses from the current user for the given page
- (NSArray *) getUserTimelineAtPage:(NSString *)page {
	NSMutableString *path = [NSMutableString 
		stringWithString:@"statuses/user_timeline.xml?page="];
	[path appendString:page];
	NSData *data = [self executeRequestOfType:@"GET" 
									   atPath:path 
								synchronously:synchronously];
	NSXMLNode *node = [self getNodeFromData:data];
	if ([[node name] isEqualToString:@"statuses"]) {
		return [self getAllStatusesFromData:data];
	} else {
		return NULL;
	}
}

// returns x most recent statuses from the specified user
- (NSArray *) getUserTimelineForUser:(NSString *)userID 
				withNumberOfStatuses:(NSString *)count {
	NSMutableString *path = [NSMutableString 
							 stringWithString:@"statuses/user_timeline/"];
	[path appendString:userID];
	[path appendString:@".xml?count="];
	[path appendString:count];
	NSData *data = [self executeRequestOfType:@"GET" 
									   atPath:path 
								synchronously:synchronously];
	NSXMLNode *node = [self getNodeFromData:data];
	if ([[node name] isEqualToString:@"statuses"]) {
		return [self getAllStatusesFromData:data];
	} else {
		return NULL;
	}
}

// returns the 20 most recent statuses from the specified user since the given
// date
- (NSArray *) getUserTimelineForUser:(NSString*)userID 
							   since:(NSString *)date {
	NSMutableString *path = [NSMutableString 
							 stringWithString:@"statuses/user_timeline/"];
	[path appendString:userID];
	[path appendString:@".xml?since="];
	[path appendString:date];
	NSData *data = [self executeRequestOfType:@"GET" 
									   atPath:path 
								synchronously:synchronously];
	NSXMLNode *node = [self getNodeFromData:data];
	if ([[node name] isEqualToString:@"statuses"]) {
		return [self getAllStatusesFromData:data];
	} else {
		return NULL;
	}
}

// returns the 20 most recent statuses from the current user since the given
// status id
- (NSArray *) getUserTimelineForUser:(NSString *)userID
						 sinceStatus:(NSString *)statusID {
	NSMutableString *path = [NSMutableString 
							 stringWithString:@"statuses/user_timeline/"];
	[path appendString:userID];
	[path appendString:@".xml?since_id="];
	[path appendString:statusID];
	[path appendString:@"&count=200"];
	NSData *data = [self executeRequestOfType:@"GET" 
									   atPath:path 
								synchronously:synchronously];
	NSXMLNode *node = [self getNodeFromData:data];
	if ([[node name] isEqualToString:@"statuses"]) {
		return [self getAllStatusesFromData:data];
	} else {
		return NULL;
	}
}

// returns the 20 most recent statuses from the current user for the given page
- (NSArray *) getUserTimelineForUser:(NSString *)userID
							  atPage:(NSString *)page {
	NSMutableString *path = [NSMutableString 
							 stringWithString:@"statuses/user_timeline/"];
	[path appendString:userID];
	[path appendString:@".xml?page="];
	[path appendString:page];
	NSData *data = [self executeRequestOfType:@"GET" 
									   atPath:path 
								synchronously:synchronously];
	NSXMLNode *node = [self getNodeFromData:data];
	if ([[node name] isEqualToString:@"statuses"]) {
		return [self getAllStatusesFromData:data];
	} else {
		return NULL;
	}
}

// returns a single status specified by the given id
- (NSXMLNode *) getStatus:(NSString *)statusID {
	NSMutableString *path = [NSMutableString 
							 stringWithString:@"statuses/show/"];
	[path appendString:statusID];
	[path appendString:@".xml"];
	NSXMLNode *node = [self getNodeFromData:[self executeRequestOfType:@"GET" 
							atPath:path synchronously:synchronously]];
	if ([[node name] isEqualToString:@"status"]) {
		return node;
	} else {
		return NULL;
	}
}

// returns the 20 most recent replies for the current user at the given page
- (NSArray *) getRepliesAtPage:(NSString *)page {
	NSMutableString *path = [NSMutableString 
							 stringWithString:@"statuses/replies.xml?page="];
	[path appendString:page];
	NSData *data = [self executeRequestOfType:@"GET" 
									   atPath:path 
								synchronously:synchronously];
	NSXMLNode *node = [self getNodeFromData:data];
	if ([[node name] isEqualToString:@"statuses"]) {
		return [self getAllStatusesFromData:data];
	} else {
		return NULL;
	}
}

// returns the 20 most recent replies since the given date
- (NSArray *) getRepliesSince:(NSString *)date {
	NSMutableString *path = [NSMutableString
							 stringWithString:@"statuses/replies.xml?since="];
	[path appendString:date];
	[path appendString:@"&count=200"];
	NSData *data = [self executeRequestOfType:@"GET" 
									   atPath:path 
								synchronously:synchronously];
	NSXMLNode *node = [self getNodeFromData:data];
	if ([[node name] isEqualToString:@"statuses"]) {
		return [self getAllStatusesFromData:data];
	} else {
		return NULL;
	}
}

// destroys the specified status
- (NSXMLNode *) destroyStatus:(NSString *)statusID {
	NSMutableString *path = [NSMutableString 
							 stringWithString:@"statuses/destroy/"];
	[path appendString:statusID];
	[path appendString:@".xml"];
	NSXMLNode *node = [self getNodeFromData:[self 
		executeRequestOfType:@"GET" atPath:path synchronously:synchronously]];
	if ([[node name] isEqualToString:@"statuses"]) {
		return node;
	} else {
		return NULL;
	}
}

@end
