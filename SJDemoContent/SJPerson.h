//
//  SJName.h
//  ContentGenerator
//
//  Created by Shane Gianelli on 3/11/13.
//  Copyright (c) 2013 Shane Gianelli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJPerson : NSObject

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;

+ (void)setFirstNames:(NSArray *)first;
+ (void)setLastNames:(NSArray *)last;

+ (SJPerson *)person;
+ (SJPerson *)male;
+ (SJPerson *)female;

- (NSString *)proper; // lastname, firstname
- (NSString *)full; // firstname lastname

@end
