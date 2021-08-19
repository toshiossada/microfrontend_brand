//
//  PushIOManager+PushIOLocation.h
//  PushIOManager
//
//  Copyright (c) 2018 Oracle Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "PushIOManager.h"
#import "PIOGeoRegion.h"
#import "PIOBeaconRegion.h"

/** PushIOLocationError enum defines the possible errors to inform application.
 *
 */
typedef NS_ENUM(NSUInteger, PushIOLocationError){
    PUSHIO_LOCATION_ERROR_UNKNOWN = 0,
    PUSHIO_LOCATION_ERROR_USER_DISABLED_LOCATION,
    PUSHIO_LOCATION_ERROR_DEVICE_DOES_NOT_SUPPORT_LOCATION,
    PUSHIO_LOCATION_ERROR_DEVICE_CANNOT_MONITOR_REGIONS,
    PUSHIO_LOCATION_ERROR_LOCATION_TEMP_ERROR
};


/**
 If you are a delegate of PushIOManager, you will also be signed up for these callbacks also.
 */
@protocol PushIOManagerLocationDelegate <PushIOManagerDelegate>

@optional

/**
 Returns you the current location as changes are detected that exceed the area of interest.
 A null location means location services have been disabled.
 */
- (void) locationDidChange:(CLLocation *)newLocation;

@end

/**PushIOManager(PushIOLocation) class presents all PushIOManager location related calls.
 Note that you can either use the PushIOManager managed CLLocationManager, just by telling PushIOManager to `startUpdatingLocationForPush`, or by using your own CLLocationManager and passing in any location updates via `setLastLocation`.
 */
@interface PushIOManager(PushIOLocation) <CLLocationManagerDelegate>


/**
 By default PushIOManager will use the "significant change" location service for detecting location.
 If you set this property, the "standard location" service will be used with this value set.
 Note that pushIOManager will not register location updates unless a new location is greater in distance from
 the old one than this location accuracy setting - or 200 meters if this value is not set.

 Assign the desiredLocationAccuracy, used by CLLocationManager instance to get the better location result. Not used when assignLastLocation is used to get the location.

 */
@property (nonatomic, assign) CLLocationAccuracy desiredLocationAccuracy;

/** Initialize the CLLocationManager and starts tracking the device location.
 *
 */
- (void)startUpdatingLocationForPush;

/** Stops tracking the device location.
 *
 */
- (void)stopUpdatingLocationForPush;


/** Application can instantiate and set the location for PushIO SDK to track. In this case PushIOManager won't instantiate the CLLocationManager internally.
 *
 */
- (void)setLastLocation:(CLLocation *)lastLocation;


/** Assign the distanceFilter, used by CLLocationManager instance to get the better location result. Not used when assignLastLocation is used to get the location.
 *
 */
- (void)setDistanceFilter:(CLLocationDistance)distanceFilter;


/**
 Method to be invoked when enters in Geofence Region.
 
 @param region       Geofence region details needed to pass to sdk.
 @param completionHandler       Callback to notify when operation complete.
 */
- (void)didEnterGeoRegion:(PIOGeoRegion *)region completionHandler:(PIOCompletionHandler)completionHandler NS_SWIFT_NAME(didEnter(region:_:));


/**
 Method to be invoked when when exits from Geofence Region.

 @param region       Geofence region details needed to pass to sdk.
 @param completionHandler       Callback to notify when operation complete.
 */
- (void)didExitGeoRegion:(PIOGeoRegion *)region completionHandler:(PIOCompletionHandler)completionHandler NS_SWIFT_NAME(didExit(region:_:));


/**
 Method to be invoked when when enters in Beacon Region.
 
 @param region       Beacon region details needed to pass to sdk.
 @param completionHandler       Callback to notify when operation complete.
 */
- (void)didEnterBeaconRegion:(PIOBeaconRegion *)region completionHandler:(PIOCompletionHandler)completionHandler NS_SWIFT_NAME(didEnter(region:_:));


/**
 Method to be invoked when when exits from Beacon Region.
 
 @param region       Beacon region details needed to pass to sdk.
 @param completionHandler       Callback to notify when operation complete.
 */
- (void)didExitBeaconRegion:(PIOBeaconRegion *)region completionHandler:(PIOCompletionHandler)completionHandler NS_SWIFT_NAME(didExit(region:_:));


@end
