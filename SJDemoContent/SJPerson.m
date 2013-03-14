//
//  SJName.m
//  ContentGenerator
//
//  Created by Shane Gianelli on 3/11/13.
//  Copyright (c) 2013 Shane Gianelli. All rights reserved.
//

#import "SJPerson.h"

#import "SJDemo.h"

@implementation SJPerson

static NSArray *maleNames = nil;
static NSArray *femaleNames = nil;
static NSArray *lastNames = nil;

+ (void)setFirstNames:(NSArray *)first {
    NSMutableArray *male = [NSMutableArray array];
    NSMutableArray *female = [NSMutableArray array];
    
    for (NSDictionary *person in first) {
        if ([person[@"gender"] isEqualToString:@"F"])
            [female addObject:person];
        else
            [male addObject:person];
    }
    
    maleNames = [male copy];
    femaleNames = [female copy];
}

+ (void)setLastNames:(NSArray *)last {
    lastNames = last;
}

- (id)initWithSex:(BOOL)male {
    if (self = [super init]) {
        _firstName = (male ? maleNames[[SJDemo next] % maleNames.count][@"name"] : femaleNames[[SJDemo next] % femaleNames.count][@"name"]);
        _lastName = lastNames[[SJDemo next] % lastNames.count];
    }
    
    return self;
}

+ (SJPerson *)person {
    return [[self alloc] initWithSex:[SJDemo boolean]];
}

+ (SJPerson *)female {
    return [[self alloc] initWithSex:NO];
}

+ (SJPerson *)male {
    return [[self alloc] initWithSex:YES];
}

- (NSString *)proper {
    return [NSString stringWithFormat:@"%@, %@",_lastName,_firstName];
}

- (NSString *)full {
    return [NSString stringWithFormat:@"%@ %@",_firstName,_lastName];
}

@end
