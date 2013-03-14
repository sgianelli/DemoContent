//
//  SJLocation.m
//  ContentGenerator
//
//  Created by Shane Gianelli on 3/11/13.
//  Copyright (c) 2013 Shane Gianelli. All rights reserved.
//

#import "SJRegion.h"

#import "SJDemo.h"

@implementation SJRegion

static BOOL addons = NO;
static NSArray *regionData = nil;

+ (void)setZIPCodeAddons:(BOOL)on {
    addons = on;
}

+ (void)setRegionData:(NSArray *)regions {
    regionData = regions;
}

- (id)init {
    if (self = [super init]) {
        
    }
    
    return self;
}

- (id)initWithCSVDict:(NSDictionary *)csv {
    if (self = [super init]) {
        _city = csv[@"primary_city"];
        _state = csv[@"state"];
        _zipcode = (addons ? [csv[@"zip"] stringByAppendingFormat:@"-%4d",[SJDemo intInRange:NSMakeRange(0, 10000)]] : csv[@"zip"]);
        _areaCode = [(NSString *)csv[@"area_codes"] componentsSeparatedByString:@","][0];
        
        _coordinates = CLLocationCoordinate2DMake([csv[@"latitude"] floatValue], [csv[@"longitude"] floatValue]);
    }
    
    return self;
}

+ (SJRegion *)region {
    return regionData[[SJDemo next] % regionData.count];
}

+ (SJRegion *)region:(NSDictionary *)csv {
    return [[self alloc] initWithCSVDict:csv];
}

- (NSString *)full {
    return [NSString stringWithFormat:@"%@ %@",[self cityState],_zipcode];
}

- (NSString *)cityState {
    return [NSString stringWithFormat:@"%@, %@",_city,_state];
}

@end
