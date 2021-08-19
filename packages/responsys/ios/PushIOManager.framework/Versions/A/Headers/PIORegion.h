//
//  PIORegion.h
//  PushIOManager
//
//  Copyright © 2018 Oracle Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PIORegion : NSObject

/**
 Apple Native or Thirdparty sdks or sources where region data is coming.
*/
@property (nonatomic, copy) NSString *source;


/**
 Geofence Zone Id.
 */
@property (nonatomic, copy) NSString *zoneId;


/**
 Geofence Zone Name.
 */
@property (nonatomic, copy) NSString *zoneName;


/**
 Dwell time of the device within the range of a geofence.
 */
@property (nonatomic) NSInteger dwellTime;


/**
 Custom Parameters to pass with Geofence information. Maximum 5 parameters are allowed.
 */
@property (nonatomic, copy) NSDictionary<NSString *, NSString *> *extra;


/**
  Do not initialize this class. Use it's subclasses `PIOGeoRegion` and `PIOBeaconRegion`
 */
-(instancetype)initWithZoneId: (NSString *)zoneId zoneName: (NSString *)zoneName source: (NSString *)source dwellTime:(NSInteger)dwellTime extra: (NSDictionary *)extra;
@end

