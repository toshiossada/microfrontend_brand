//
//  PIOMCMessage.h
//  PushIOManager
//
//  Copyright (c) 2018 Oracle Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PIOMCMessage : NSObject

@property(nonatomic, strong) NSString *messageID;

@property(nonatomic, strong) NSString *subject;

@property(nonatomic, strong) NSString *message;

@property(nonatomic, strong) NSString *iconURL;

@property(nonatomic, strong) NSString *messageCenterName;

@property(nonatomic, strong) NSString *deeplinkURL;

@property(nonatomic, strong) NSString *richMessageHTML;

@property(nonatomic, strong) NSString *richMessageURL;

@property(nonatomic, strong) NSDate *sentTimestamp;

@property(nonatomic, strong) NSDate *expiryTimestamp;


-(instancetype) initWithID:(NSString *)messageID subject:(NSString *)subject message:(NSString *)message iconURL:(NSString *)iconURL messageCenterName:(NSString *)messageCenterName deeplinkURL:(NSString *)deeplinkURL richMessageHTML:(NSString *)richMessageHTML richMessageURL:(NSString *)richMessageURL sentTimestamp:(NSDate *)sentTimestamp expiryTimestamp:(NSDate *)expiryTimestamp;

@end
