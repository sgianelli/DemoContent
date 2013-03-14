//
//  SJPhone.h
//  ContentGenerator
//
//  Created by Shane Gianelli on 3/11/13.
//  Copyright (c) 2013 Shane Gianelli. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SJRegion;

@interface SJPhone : NSObject

@property (nonatomic, strong) NSString *number; // xxx - xxxx
@property (nonatomic, strong) NSString *areaCode; // xxx
@property (nonatomic, strong) NSString *extension; // xxxx
//@property (nonatomic, strong) NSString *countryCode; // +x(x)

+ (SJPhone *)phone;
+ (SJPhone *)phone:(SJRegion *)region;

- (NSString *)full; // (xxx) xxx - xxxx Ext. xxxx
- (NSString *)medium; // (xxx) xxx - xxxx

@end
