//
//  SJLocation.m
//  ContentGenerator
//
//  Created by Shane Gianelli on 3/12/13.
//  Copyright (c) 2013 Shane Gianelli. All rights reserved.
//

#import "SJLocation.h"
#import "SJRegion.h"

#import "SJDemo.h"

@implementation SJLocation

static NSArray *streetNames = nil;
static NSArray *streetSuffixes = nil;

+ (void)initialize {
    streetSuffixes = @[@"Rd", @"Blvd", @"Ave", @"Cir", @"St"];
}

+ (void)setStreetNames:(NSArray *)streets {
    streetNames = streets;
}

- (id)init {
    if (self = [self initWithRegion:[SJRegion region]]) {

    }
    
    return self;
}

- (id)initWithRegion:(SJRegion *)region {
    if (self = [super init]) {
        _street = streetNames[[SJDemo next] % streetNames.count];
        _suffix = streetSuffixes[[SJDemo next] % streetSuffixes.count];
        _number = [SJDemo numberWithLength:[SJDemo intInRange:NSMakeRange(2, 5)]];

        _region = region;
    }
    
    return self;
}

+ (SJLocation *)location {
    return [[self alloc] init];
}

+ (SJLocation *)location:(SJRegion *)region {
    return [[self alloc] initWithRegion:region];
}

- (NSString *)full {
    return [NSString stringWithFormat:@"%@, %@",[self address],[_region full]];
}

- (NSString *)address {
    return [NSString stringWithFormat:@"%@ %@ %@",_number,_street,_suffix];
}

@end
