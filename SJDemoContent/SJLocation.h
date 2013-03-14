//
//  SJLocation.h
//  ContentGenerator
//
//  Created by Shane Gianelli on 3/12/13.
//  Copyright (c) 2013 Shane Gianelli. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SJRegion;

@interface SJLocation : NSObject

@property(nonatomic, weak) SJRegion *region;

@property(nonatomic, strong, readonly) NSString *street;
@property(nonatomic, strong, readonly) NSString *number;
@property(nonatomic, strong, readonly) NSString *suffix;

+ (void)setStreetNames:(NSArray *)streets;

+ (SJLocation *)location;
+ (SJLocation *)location:(SJRegion *)region;

- (NSString *)full; // number street, city, state zip(+addon)
- (NSString *)address; // number street

@end
