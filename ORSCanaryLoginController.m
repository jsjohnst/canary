//
//  ORSCanaryLoginController.m
//  Canary
//
//  Created by Nicholas Toumpelis on 12/04/2009.
//  Copyright 2009 Ocean Road Software. All rights reserved.
//
//  Version 0.7

#import "ORSCanaryLoginController.h"

@implementation ORSCanaryLoginController

// Init
- (id) initWithWindow:(NSWindow *)window {
	if (self = [super initWithWindow:window]) {
		twitterEngine = [ORSTwitterEngine sharedTwitterEngine];
		defaults = [NSUserDefaults standardUserDefaults];
		authenticator = [[ORSCredentialsManager alloc] init];
	}
	return self;
}

// Delegate method: called when the control text changes
- (void) controlTextDidChange:(NSNotification *)aNotification {
	if ([aNotification object] == userIDComboBox) {
		if ([[userIDComboBox stringValue] isEqualToString:@""] ||
				[[userIDComboBox stringValue] isEqualToString:@" "]) {
			[passwordSecureTextField setStringValue:@""];
		}
	}
}

// Delegate method: called when the control text started to be edited
/*- (void) controlTextDidBeginEditing:(NSNotification *)aNotification {
	if ([aNotification object] == passwordSecureTextField) {
		if (![authenticator hasPasswordForUser:[userIDComboBox stringValue]]) {
			NSString *potentialPassword = [authenticator readStoredTwitterPasswordForUsername:[userIDComboBox 
															stringValue]];
			if (potentialPassword != NULL) {
				[passwordSecureTextField setStringValue:potentialPassword];
			}
		}
	}
}*/

// Action: calls the sheetDidEnd method with a return code of 0 (closes the 
// sheet)
- (IBAction) closeUserManagerSheet:sender {
	ORSCanaryController *canaryController = [ORSCanaryController sharedController];
	[twitterEngine setSessionUserID:[canaryController prevUserID]];
	[twitterEngine setSessionPassword:[canaryController prevPassword]];
	[defaults setObject:[canaryController prevUserID]
				 forKey:@"CanaryCurrentUserID"];
	[self.window orderOut:sender];
	[NSApp endSheet:self.window returnCode:0];
}

// Action: calls the sheetDidEnd method with a return code of 1 (login)
- (IBAction) login:sender {
	ORSCanaryController *canaryController = [ORSCanaryController 
											 sharedController];
	[canaryController saveLastIDs];
	[twitterEngine endSession];
	[twitterEngine setSessionUserID:NULL];
	[twitterEngine setSessionPassword:NULL];
	[authenticatedTextField setStringValue:@"Authenticating..."];
	[twitterEngine setSessionUserID:[userIDComboBox stringValue]];
	[twitterEngine setSessionPassword:[passwordSecureTextField 
									   stringValue]];
 	if ([twitterEngine verifyCredentials]) {
		[authenticatedTextField setStringValue:@"Authenticated."];
		[self.window orderOut:sender];
		[NSApp endSheet:self.window returnCode:1];
	} else {
		[authenticatedTextField setStringValue:@"Could not be authenticated."];
		[twitterEngine setSessionUserID:[canaryController prevUserID]];
		[twitterEngine setSessionPassword:[canaryController prevPassword]];
	}
}

// sheetDidEnd: Determines the course of action depending on what the user 
// clicked
- (void) didEndUserManagerSheet:(NSWindow *)sheet
					 returnCode:(int)returnCode
					contextInfo:(void *)contextInfo {
	if (returnCode == 0) {
		return;
	} else if (returnCode == 1) {
		ORSCanaryController *canaryController = [ORSCanaryController 
											  sharedController];
		canaryController.betweenUsers = YES;
		canaryController.firstBackgroundReceivedDMRetrieval = YES;
		[[canaryController cacheManager] resetAllCaches];
		
		[canaryController setStatuses:nil];
		[canaryController setReceivedDirectMessages:nil];
		[canaryController setSentDirectMessages:nil];
		
		// Need to make this simpler
		[defaults setObject:[userIDComboBox stringValue]
					 forKey:@"CanaryCurrentUserID"];
		NSArray *userIDList = [defaults stringArrayForKey:@"CanaryUserIDList"];
		NSMutableArray *mutableUserIDList;
		if (!userIDList) {
			mutableUserIDList = [NSMutableArray array];
		} else {
			mutableUserIDList = [NSMutableArray arrayWithArray:userIDList];
		}			
		if (![mutableUserIDList containsObject:[userIDComboBox stringValue]]) {
			[mutableUserIDList addObject:[userIDComboBox stringValue]];
			[defaults setObject:mutableUserIDList forKey:@"CanaryUserIDList"];
			[authenticator 
				addPassword:[passwordSecureTextField stringValue]
							   forUser:[userIDComboBox stringValue]];
		}
		[twitterEngine setSessionUserID:[userIDComboBox stringValue]];
		[twitterEngine setSessionPassword:[passwordSecureTextField 
										   stringValue]];
		if (![authenticator 			  
			  setPassword:[passwordSecureTextField stringValue]
								forUser:[userIDComboBox stringValue]]) {
			[authenticator addPassword:[passwordSecureTextField stringValue] 
							   forUser:[userIDComboBox stringValue]];
			[twitterEngine setSessionUserID:[userIDComboBox stringValue]];
			[twitterEngine setSessionPassword:[passwordSecureTextField 
											   stringValue]];
		}
		[canaryController setVisibleUserID:[NSString stringWithFormat:@"  %@",
								[twitterEngine sessionUserID]]];
		
		[canaryController setupReceivedDMTimer];
		[canaryController.statusBarTextField setHidden:YES];
		[canaryController.statusBarImageView setHidden:YES];
		[canaryController.statusBarButton setEnabled:NO];
		[canaryController.statusBarButton setHidden:YES];
		[canaryController changeTimeline:nil];
	}
	[authenticator freeBuffer];
}

// Delegate: Whenever the combo box selection changes, we fill the password text 
// field
- (void) comboBoxSelectionDidChange:(NSNotification *)notification {
	[authenticatedTextField setStringValue:@""];
	[self fillPasswordTextField];
}

// Fills the password text field with the password
- (void) fillPasswordTextField {
	if ([authenticator
			hasPasswordForUser:[userIDComboBox stringValue]]) {
		[passwordSecureTextField setStringValue:[authenticator
												 fetchedPassword]];
		[authenticator freeBuffer];
	} else {
		[passwordSecureTextField setStringValue:@""];
	}
}

@end
