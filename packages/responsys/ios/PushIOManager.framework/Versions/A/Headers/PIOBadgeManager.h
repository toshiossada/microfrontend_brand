//
//  PIOBadgeManager.h
//  PushIOManager
//
//  Copyright © 2019 Oracle Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PushIOManager.h"

@interface PIOBadgeManager : NSObject

/**
 Set the application badge count and also sync with server. In case of error while syncing badge count will not be set.
 
 @param badgeCount count needed to set on app icon.
 @param completionHandler Callback to notify when badge count set operation completes.
 */
- (void)setBadgeCount:(NSInteger)badgeCount completionHandler:(PIOCompletionHandler)completionHandler;

/**
 Reset the application badge count to 0 and also sync with server. In case of error while syncing badge count will not be reset. This api will remove the badge count icon from app icon.
 
 @param completionHandler Callback to notify when reset badge count operation completes.
 */
- (void)resetBadgeCountWithCompletionHandler:(PIOCompletionHandler)completionHandler;

/**
 Return the current local badge count of app.
 
 @return Return the badge count value.
 */
- (NSInteger)getBadgeCount;

@end
