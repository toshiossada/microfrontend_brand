//
//  PIOBeaconRegion.h
//  PushIOManager
//
//  Copyright © 2018 Oracle Inc. All rights reserved.
//

#import "PIORegion.h"

@interface PIOBeaconRegion : PIORegion

/**
 Beacon id.
 */
@property (nonatomic, copy) NSString *beaconId;


/**
 Beacon name.
 */
@property (nonatomic, copy) NSString *beaconName;


/**
 Tag associated with beacon. Any useful information can be passed as a tag.
 */
@property (nonatomic, copy) NSString *beaconTag;


/**
 UUID of EddyStone Beacon of Beacon. If beacon is not eddystone use this for any other id purpose like eddystoneurl.
 */
@property (nonatomic, copy) NSString *eddyStoneId1;


/**
 Instance ID of EddyStone Beacon. If beacon is not eddystone use this for any other id purpose like eddystoneurl.
 */
@property (nonatomic, copy) NSString *eddyStoneId2;


/**
 Proximity UUID of iBeacon. If beacon is not iBeacon use this for any other id purpose if required like eddystoneurl.
 */
@property (nonatomic, copy) NSString *iBeaconUUID;


/**
 Major value of iBeacon.
 */
@property (nonatomic) NSInteger iBeaconMajor;


/**
 Minor value of iBeacon.
 */
@property (nonatomic) NSInteger iBeaconMinor;


/**
 Proximity value of Beacon - Immediate, Near, Far, Unknown.
 */
@property (nonatomic, copy) NSString *proximity;


/**
 Constructor to instantiate the PIOBeaconRegion for iBeacon.
 
 @param iBeaconUUID     Proximity UUID of iBeacon.
 @param iBeaconMajor    Major value of iBeacon.
 @param iBeaconMinor    Minor value of iBeacon.
 @param beaconId        Beacon Id.
 @param beaconName      Beacon name.
 @param beaconTag       Tag associated with beacon. Any useful information can be passed as a tag.
 @param proximity       Proximity value of Beacon - Immediate, Near, Far, Unknown.
 @param source          Specify from where region data is coming - Apple Native or Thirdparty sdk name.
 @param zoneId          Beacon Zone Id.
 @param zoneName        Beacon Zone Name.
 @param dwellTime       Dwell time of the device within the range of a Beacon.
 @param extra           Custom Parameters to pass with Beacon information. Maximum 5 parameters are allowed.
 */
-(instancetype)initWithiBeaconUUID:(NSString *)iBeaconUUID iBeaconMajor:(NSInteger)iBeaconMajor iBeaconMinor:(NSInteger)iBeaconMinor beaconId: (NSString *)beaconId beaconName:(NSString *)beaconName beaconTag: (NSString *)beaconTag proximity: (NSString *)proximity source: (NSString *)source zoneId: (NSString *)zoneId zoneName: (NSString *)zoneName dwellTime:(NSInteger)dwellTime extra: (NSDictionary *)extra;

/**
 Constructor to instantiate the PIOBeaconRegion for EddyStone Beacons.
 
 @param eddyStoneId1    UUID of EddyStone Beacon. If beacon is not eddystone use this for any other id purpose like            eddystoneurl.
 @param eddyStoneId2    Instance Id of EddyStone Beacon. If beacon is not eddystone use this for any other id purpose like eddystoneurl.
 @param beaconId        Beacon Id.
 @param beaconName      Beacon name.
 @param beaconTag       Tag associated with beacon. Any useful information can be passed as a tag.
 @param proximity       Proximity value of Beacon - Immediate, Near, Far, Unknown.
 @param source          Specify from where region data is coming - Apple Native or Thirdparty sdk name.
 @param zoneId          Beacon Zone Id.
 @param zoneName        Beacon Zone Name.
 @param dwellTime       Dwell time of the device within the range of a Beacon.
 @param extra           Custom Parameters to pass with Beacon information. Maximum 5 parameters are allowed.
 */
-(instancetype)initWithEddyStoneId1:(NSString *)eddyStoneId1 eddyStoneId2:(NSString *)eddyStoneId2 beaconId: (NSString *)beaconId beaconName:(NSString *)beaconName beaconTag: (NSString *)beaconTag iBeaconUUID:(NSString *)iBeaconUUID proximity: (NSString *)proximity source: (NSString *)source zoneId: (NSString *)zoneId zoneName: (NSString *)zoneName dwellTime:(NSInteger)dwellTime extra: (NSDictionary *)extra;
@end

