//
//  PIOGeoRegion.h
//  PushIOManager
//
//  Copyright © 2018 Oracle Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PIORegion.h"


@interface PIOGeoRegion : PIORegion

/**
 Geofence id.
 */
@property (nonatomic, copy) NSString *geofenceId;


/**
 Geofence name.
 */
@property (nonatomic, copy) NSString *geofenceName;


/**
 Speed while entering geofence.
 */
@property (nonatomic) double speed;


/**
 Bearing while entering geofence.
 */
@property (nonatomic) double bearing;


/**
 Constructor to instantiate the PIOGeoRegion.
 
 @param geofenceId      Geofence id.
 @param geofenceName    Geofence name.
 @param speed           Speed while entering geofence.
 @param bearing         Bearing while entering geofence.
 @param source          Specify from where region data is coming - Apple Native or Thirdparty sdk name.
 @param zoneId          Geofence Zone Id.
 @param zoneName        Geofence Zone Name.
 @param dwellTime       Dwell time of the device within the range of a geofence.
 @param extra           Custom Parameters to pass with Geofence information. Maximum 5 parameters are allowed.
 */
-(instancetype)initWithGeofenceId:(NSString *)geofenceId geofenceName:(NSString *)geofenceName speed:(double)speed bearing: (double)bearing source: (NSString *)source zoneId:(NSString *)zoneId zoneName:(NSString *)zoneName dwellTime:(NSInteger)dwellTime extra:(NSDictionary *)extra;

@end
