//
//  SJContentGenerator.h
//  ContentGenerator
//
//  Created by Shane Gianelli on 3/11/13.
//  Copyright (c) 2013 Shane Gianelli. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SJPerson.h"
#import "SJRegion.h"
#import "SJLocation.h"
#import "SJPhone.h"

@class SJPerson;
@class SJRegion;
@class SJPhone;

@interface SJDemo : NSObject

// A seed is generated automatically at launch, that seed is replaced
// here if the developer desires consistent results
+ (void)setSeed:(unsigned int)seed;

// Get the next random integer from rand()
+ (int)next;

// Larger, defined objects
+ (SJPerson *)person;
+ (SJRegion *)region;
+ (SJLocation *)location;
+ (SJPhone *)phone;

// Dates

// returns a date +/- the current
+ (NSDate *)date;

// returns a date between x years ago and now
+ (NSDate *)dateSinceYear:(NSInteger)year;
+ (NSDate *)dateInLastYear;

+ (NSDate *)dateSinceYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
+ (NSDate *)dateAroundNow:(NSInteger)days;

+ (NSDate *)dateWithRange:(NSTimeInterval)range;

// Numbers
+ (float)floatInRange:(NSRange)range;
+ (int)intInRange:(NSRange)range;
+ (BOOL)boolean;

+ (NSNumber *)nFloatInRange:(NSRange)range;
+ (NSNumber *)nIntInRange:(NSRange)range;
+ (NSNumber *)nBoolean;

// Strings
+ (NSString *)lipsumWithWords:(NSInteger)wordCount newlines:(BOOL)nl;

+ (NSString *)numberWithLength:(NSInteger)length;

@end
