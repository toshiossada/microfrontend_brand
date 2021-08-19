//
//  PIOPreference.h
//  PushIOManager
//
//  Copyright (c) 2018 Oracle Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const PIOErrorDomainPreference;


/**
 Indicates the expected type of value for a preference.
 */
typedef NS_ENUM(NSUInteger, PIOPreferenceType) {
    // The value should be expressed as (NSString *) with a length of no more
    // than 255 characters.
    PIOPreferenceTypeString = 0,
    // The value should be expressed as an (NSNumber *).
    PIOPreferenceTypeNumeric,
    // The value should be expressed as an (NSNumber *), and will be treated
    // as a boolean.
    PIOPreferenceTypeBoolean
};


/**
 Represents a Notification Preference.
 */
@interface PIOPreference : NSObject <NSCoding>

- (instancetype)initWithKey:(NSString *)key label:(NSString *)label type:(PIOPreferenceType)type;

/**
 A unique identifier for the preference. Keys should be composed of alphanumeric
 characters including underscore and should be between 1 and 25 characters in
 length (regex: ^([a-zA-Z0-9_]{1,25})$).
 */
@property (nonatomic, copy, readonly) NSString *key;

/**
 A human-readable name. Labels should be between 1 and 1024 characters in
 length.
 */
@property (nonatomic, copy) NSString *label;

/**
 The expected type of value.
 */
@property (nonatomic, assign, readonly) PIOPreferenceType type;

/**
 The preference's value according to its type.
 */
@property (nonatomic, strong) id value;

@end
