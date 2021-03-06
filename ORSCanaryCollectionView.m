//
//  ORSCanaryCollectionView.m
//  Canary
//
//  Created by Nicholas Toumpelis on 12/04/2009.
//  Copyright 2009 Ocean Road Software. All rights reserved.
//
//  Version 0.7

#import "ORSCanaryCollectionView.h"

@implementation ORSCanaryCollectionView

- (void) drawRect:(NSRect)rect {
	if ([[self content] count] > 0) {
		[super drawRect:rect];
	} else {
		NSRect bounds = [self bounds];
		[[NSColor controlColor] set];
		[NSBezierPath fillRect:bounds];
		
		NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
		[attributes setObject:[NSFont boldSystemFontOfSize:12] 
					   forKey:NSFontAttributeName];
		[attributes setObject:[NSColor grayColor]
					   forKey:NSForegroundColorAttributeName];
		NSString *string = @"This timeline is empty.";
		NSSize strSize = [string sizeWithAttributes:attributes];
		NSPoint strOrigin;
		strOrigin.x = bounds.origin.x + (bounds.size.width - strSize.width)/2;
		strOrigin.y = bounds.origin.y + (bounds.size.height - strSize.height)/2;
		[string drawAtPoint:strOrigin withAttributes:attributes];
	}
}

- (BOOL) isOpaque {
	return YES;
}

@end
