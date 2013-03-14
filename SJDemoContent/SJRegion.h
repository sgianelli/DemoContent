//
//  SJLocation.h
//  ContentGenerator
//
//  Created by Shane Gianelli on 3/11/13.
//  Copyright (c) 2013 Shane Gianelli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJRegion : NSObject

@property(nonatomic, strong) NSString *city;
@property(nonatomic, strong) NSString *state;
@property(nonatomic, strong) NSString *zipcode;
@property(nonatomic, strong) NSString *areaCode;

@property(nonatomic) CLLocationCoordinate2D coordinates;

+ (void)setZIPCodeAddons:(BOOL)on; // default=NO
+ (void)setRegionData:(NSArray *)regions;

+ (SJRegion *)region;
+ (SJRegion *)region:(NSDictionary *)csv;

- (NSString *)full; // city, state zip(+addon)
- (NSString *)cityState; // city, state

@end
