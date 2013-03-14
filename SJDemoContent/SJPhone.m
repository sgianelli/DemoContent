//
//  SJPhone.m
//  ContentGenerator
//
//  Created by Shane Gianelli on 3/11/13.
//  Copyright (c) 2013 Shane Gianelli. All rights reserved.
//

#import "SJPhone.h"

#import "SJDemo.h"
#import "SJRegion.h"

@implementation SJPhone

- (id)init {
    if (self = [super init]) {
        _number = [NSString stringWithFormat:@"%@ - %@",[SJDemo numberWithLength:3],[SJDemo numberWithLength:4]];
        _areaCode = [NSString stringWithFormat:@"%@",[SJDemo numberWithLength:3]];
        _extension = [NSString stringWithFormat:@"%@",[SJDemo numberWithLength:4]];
    }
    
    return self;
}

+ (SJPhone *)phone:(SJRegion *)region {
    SJPhone *phone = [self phone];
    phone.areaCode = region.areaCode;
    
    return phone;
}

+ (SJPhone *)phone {
    return [[self alloc] init];
}

- (NSString *)full {
    return [NSString stringWithFormat:@"%@ Ext. %@",[self medium],_extension];
}

- (NSString *)medium {
    return [NSString stringWithFormat:@"(%@) %@",_areaCode,_number];
}

@end
