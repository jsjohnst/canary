//
//  ORSTwitterEngine.h
//  Twitter Engine
//
//  Created by Nicholas Toumpelis on 12/04/2009.
//  Copyright 2009 Ocean Road Software. All rights reserved.
//
//  Version 0.7

#import <Cocoa/Cocoa.h>
#import "ORSSession.h"

#define DEVICE_NONE		@"none"
#define DEVICE_IM		@"im"
#define DEVICE_SMS		@"sms"

@interface ORSTwitterEngine : NSObject {

@private
	ORSSession *session;
	NSMutableData *dataReceived;
	BOOL synchronously;
	NSURLConnection *mainConnection;
	NSMutableArray *sessionQueue;
}

+ (ORSTwitterEngine *) sharedTwitterEngine;
+ (id) allocWithZone:(NSZone *)zone;
- (id) initSynchronously:(BOOL)synchr 
			  withUserID:(NSString *)userID
			 andPassword:(NSString *)password;
- (NSString *) sessionUserID;
- (void) setSessionUserID:(NSString *)theSessionUserID;
- (NSString *) sessionPassword;
- (void) setSessionPassword:(NSString *)theSessionPassword;
- (NSData *) executeRequestOfType:(NSString *)type
						   atPath:(NSString *)path
					synchronously:(BOOL)synchr;
- (NSData *) executeUnencodedRequestOfType:(NSString *)type
									atPath:(NSString *)path
							 synchronously:(BOOL)synchr;
- (void) simpleExecuteRequestOfType:(NSString *)type
							 atPath:(NSString *)path
					  synchronously:(BOOL)synchr;
- (NSXMLDocument *) getXMLDocumentFromData:(NSData *)data;
- (NSXMLNode *) getNodeFromData:(NSData *)userData;
- (NSArray *) getAllStatusesFromData:(NSData *)statuses;
- (NSArray *) getAllUsersFromData:(NSData *)users;
- (NSArray *) getAllDMsFromData:(NSData *)directMessages;

// Status methods
- (NSArray *) getPublicTimeline;
- (NSArray *) getPublicTimelineSinceStatus:(NSString *)statusID;
- (NSArray *) getFriendsTimeline;
- (NSArray *) getFriendsTimelineSinceStatus:(NSString *)statusID;
- (NSArray *) getUserTimeline;
- (NSArray *) getUserTimelineForUser:(NSString *)userID;
- (NSArray *) getUserTimelineSinceStatus:(NSString *)statusID;
- (NSXMLNode *) sendUpdate:(NSString *)text inReplyTo:(NSString *)statusID;
- (NSArray *) getReplies;
- (NSArray *) getRepliesSinceStatus:(NSString *)statusID;

// Direct Message methods
- (NSArray *) getReceivedDMs;
- (NSArray *) getReceivedDMsSinceDM:(NSString *)dmID;
- (NSArray *) getSentDMs;
- (NSArray *) getSentDMsSinceDM:(NSString *)dmID;

// Friendship methods
- (BOOL) createFriendshipWithUser:(NSString *)userID;
- (BOOL) destroyFriendshipWithUser:(NSString *)userID;
- (BOOL) user:(NSString *)userIDA isFriendWithUser:(NSString *)userIDB;

// Account methods
- (BOOL) verifyCredentials;
- (BOOL) endSession;

// Favorite methods
- (NSArray *) getFavorites;
- (NSArray *) getFavoritesSinceStatus:(NSString *)statusID;

// Notification methods
- (BOOL) followUser:(NSString *)userID;
- (BOOL) leaveUser:(NSString *)userID;

// Block methods
- (BOOL) blockUser:(NSString *)userID;
- (BOOL) unblockUser:(NSString *)userID;

@property (copy) NSMutableData *dataReceived;
@property BOOL synchronously;
@property (copy) NSURLConnection *mainConnection;
@property (retain) ORSSession *session;

@end
