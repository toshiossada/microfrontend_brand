//
//  PIONotificationCategory.h
//  PushIOManager
//
//  Copyright (c) 2018 Oracle Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>

@interface PIONotificationCategory : NSObject

/**
 Category identifier.
 */
@property (nonatomic, copy) NSString *identifier;

/**
 List of actions associated for the category.
 */
@property (nonatomic, copy) NSArray *actions;

/**
 List of category itent identifiers.
 NOTE: Applicable only in iOS 10+.
 */
@property (nonatomic, copy) NSArray *intentIdentifiers;


/**
 Notification category placeholder, appears when preview is disabled from the notification settings.
 NOTE: Applicable only in iOS 11+.
 */
@property (nonatomic, copy) NSString *hiddenPreviewsBodyPlaceholder;


/**
 Options for category.
 NOTE: Applicable only in iOS 10+
 */
@property (nonatomic, assign) UNNotificationCategoryOptions options;


/**
 Convenient constructor to instantiate the PIONotificationCategory

 @param identifier Category identifier.
 @param actions list of actions for category.
 @return instance of PIONotificationCategory.
 */
-(instancetype)initWithIdentifier:(NSString *)identifier
                actions:(NSArray *)actions;


/**
 Convenient constructor to instantiate the PIONotificationCategory.

 @param identifier Category identifier.
 @param actions List of actions for category.
 @param intentIdentifiers List of intent identifiers for category. iOS10+.
 @param options Category options. iOS10+.
 @return Instance of PIONotificationCategory.
 */
-(instancetype)initWithIdentifier:(NSString *)identifier
                actions:(NSArray *)actions
      intentIdentifiers:(NSArray *)intentIdentifiers
                options:(UNNotificationCategoryOptions)options;


/**
 Convenient constructor to instantiate the PIONotificationCategory.

 @param identifier Category identifier.
 @param actions List of actions for category.
 @param intentIdentifiers List of intent identifiers for category. iOS10+.
 @param hiddenPreviewsBodyPlaceholder Placeholder text when notification preview is hidden. iOS11+
 @param options Category options. iOS10+.
 @return Instance of PIONotificationCategory.
 */
-(instancetype)initWithIdentifier:(NSString *)identifier actions:(NSArray *)actions intentIdentifiers:(NSArray *)intentIdentifiers hiddenPreviewsBodyPlaceholder:(NSString *)hiddenPreviewsBodyPlaceholder options:(UNNotificationCategoryOptions)options;


@end

@interface PIONotificationAction : NSObject

/**
 Action identifier.
 */
@property (nonatomic, strong) NSString *identifier;

/**
 Human readable title, displayed to user.
 */
@property (nonatomic, strong) NSString *title;

/**
 Determines if actions is destructive.
 */
@property (nonatomic, assign) BOOL isDestructive;

/**
 Determines if action invokes the application to foreground.
 */
@property (nonatomic, assign) BOOL isForeground;

/**
 If set YES iOS asks for the authentication when action is performed/tapped.
 */
@property (nonatomic, assign) BOOL isAuthenticationRequired;


/**
 Convenient constructor to instantiate the PIONotificationAction.

 @param identifier Action identifier.
 @param title Action title, diplayed to user.
 @param isDestructive Determines if action is of destructive type.
 @param isForeground Determines if it requires authentication to perform the action.
 @param isAuthenticationRequired If set YES, iOS asks for the authentication when action performed.
 @return Instance of PIONotificationAction.
 */
-(id)initWithIdentifier:(NSString *)identifier
                  title:(NSString *)title
                  isDestructive:(BOOL)isDestructive
               isForeground:(BOOL)isForeground
             isAuthenticationRequired:(BOOL)isAuthenticationRequired;

@end
