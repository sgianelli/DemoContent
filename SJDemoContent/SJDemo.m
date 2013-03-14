//
//  SJContentGenerator.m
//  ContentGenerator
//
//  Created by Shane Gianelli on 3/11/13.
//  Copyright (c) 2013 Shane Gianelli. All rights reserved.
//

#import "SJDemo.h"

@implementation SJDemo

static unsigned int seed;

static const long SECONDS_IN_HOUR = 60 * 60;
static const long SECONDS_IN_DAY = SECONDS_IN_HOUR * 24;
static const long SECONDS_IN_YEAR = SECONDS_IN_DAY * 365;

static NSArray *lipsumBody = nil;
static NSArray *lastNames = nil;
static NSArray *firstNames = nil;
static NSArray *streetNames = nil;
static NSArray *regions = nil;

#define kBundle(x,y) [[NSBundle bundleForClass:[self class]] pathForResource:x ofType:y]

static NSString *lipsumPath     = @"data.bundle/lipsum";
static NSString *firstnamePath  = @"data.bundle/firstnames";
static NSString *lastnamePath   = @"data.bundle/lastnames";
static NSString *streetPath     = @"data.bundle/allstreets";
static NSString *regionPath     = @"data.bundle/regiondata";

void failCheck(NSString *filename, NSError *error) {
    if (error) {
        NSLog(@"Could not load %@, failing with error: %@",filename,error);
        exit(-1);
    }
}

NSString* trimNewlines(NSString *string) {
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\n\r"]];
}

+ (void)initialize {
    // initialize the seed to a random value
    srand(seed = time(NULL));
    
    NSError *error = nil;
    
    NSString *lipsumBodyTemp = [NSString stringWithContentsOfFile:kBundle(lipsumPath, @"txt") encoding:NSUTF8StringEncoding error:&error];
    failCheck(@"lipsum.txt", error);
    
    NSString *firstNamesString = [NSString stringWithContentsOfFile:kBundle(firstnamePath, @"txt") encoding:NSUTF8StringEncoding error:&error];
    failCheck(@"firstname.txt", error);
    
    NSString *lastNamesString = [NSString stringWithContentsOfFile:kBundle(lastnamePath, @"txt") encoding:NSUTF8StringEncoding error:&error];
    failCheck(@"lastname.txt", error);
    
    NSString *streetsString = [NSString stringWithContentsOfFile:kBundle(streetPath, @"txt") encoding:NSUTF8StringEncoding error:&error];
    failCheck(@"allstreets.txt", error);
    
    NSString *regionsString = [NSString stringWithContentsOfFile:kBundle(regionPath, @"csv") encoding:NSUTF8StringEncoding error:&error];
    failCheck(@"regiondata.csv", error);
    
    // break lipsum into words
    lipsumBody = [lipsumBodyTemp componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \n"]];
    
    // create array of first names, with a token for gender
    NSMutableArray *firstTemp = [NSMutableArray array];
    NSArray *split = [firstNamesString componentsSeparatedByString:@"\n"];
    
    for (NSString *entry in split) {
        if (entry.length == 0)
            continue;
        
        NSString *stripped = trimNewlines(entry);
        NSArray *pieces = [stripped componentsSeparatedByString:@" "];
        [firstTemp addObject:@{
         @"name": [pieces[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]],
         @"gender": [pieces[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
         }];
    }
    
    firstNames = [firstTemp copy];
    
    // create array of last names
    NSMutableArray *lastNamesTemp = [NSMutableArray arrayWithArray:[lastNamesString componentsSeparatedByString:@"\n"]];
    
    for (int i = 0; i < lastNamesTemp.count; i++)
        [lastNamesTemp replaceObjectAtIndex:i withObject:trimNewlines(lastNamesTemp[i])];
    
    lastNames = [lastNamesTemp copy];
    
    // create array of street names
    NSMutableArray *streetNamesTemp = [NSMutableArray arrayWithArray:[streetsString componentsSeparatedByString:@"\n"]];
    
    for (int i = 0; i < streetNamesTemp.count; i++)
        [streetNamesTemp replaceObjectAtIndex:i withObject:trimNewlines(streetNamesTemp[i])];
    
    streetNames = [streetNamesTemp copy];
    
    // parse region csv data...
    NSMutableArray *regionsTemp = [NSMutableArray array];
    NSMutableArray *keys = [NSMutableArray array];
    NSArray *lines = [regionsString componentsSeparatedByString:@"\n"];
    
    for (int i = 0; i < lines.count; i++) {
        NSMutableArray *pieces = [NSMutableArray arrayWithArray:[lines[i] componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]]];
        
        // if its the first entry, it just needs to declare a list of the keys for each column
        if (i == 0) {
            for (NSString *piece in pieces)
                if ([piece stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length != 0)
                    [keys addObject:[piece substringWithRange:NSMakeRange(1, piece.length - 2)]] ;
        } else {
        // otherwise it just puts each piece into a dictionary in order of column-key
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            
            for (int i = 0; i < MIN(keys.count, pieces.count); i++) {
                int length = [pieces[i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length;
                
                if (length != 0)
                    [dict setObject:[pieces[i] substringWithRange:NSMakeRange(1, [pieces[i] length] - 2)] forKey:keys[i]]  ;
            }
            
            [regionsTemp addObject:[SJRegion region:dict]];
        }
    }
    
    regions = [regionsTemp copy];
    
    [SJRegion setRegionData:regions];
    
    [SJLocation setStreetNames:streetNames];
    
    [SJPerson setFirstNames:firstNames];
    [SJPerson setLastNames:lastNames];
}

+ (void)setSeed:(unsigned int)newSeed {
    seed = newSeed;
    
    srand(seed);
}

+ (int)next {
    return rand();
}

#pragma mark - Objects

+ (SJPerson *)person {
    return [SJPerson person];
}
+ (SJRegion *)region {
    return [SJRegion region];
}
+ (SJLocation *)location {
    return [SJLocation location];
}
+ (SJPhone *)phone {
    return [SJPhone phone];
}

#pragma mark - Dates

// 1970 <= year <= 2038
+ (NSDate *)dateOfYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    comps.year = year;
    comps.month = month;
    comps.day = day;
    
    return [cal dateFromComponents:comps];
}

+ (NSDate *)dateSinceYear:(NSInteger)year {
    return [self dateWithRange:[[self dateOfYear:year month:0 day:1] timeIntervalSinceNow]];
}

+ (NSDate *)dateInLastYear {
    return [self dateWithRange:SECONDS_IN_YEAR];
}

+ (NSDate *)dateSinceYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    return [self dateWithRange:[[self dateOfYear:year month:month day:day] timeIntervalSinceNow]];
}

+ (NSDate *)dateAroundNow:(NSInteger)days {
    return [NSDate dateWithTimeIntervalSinceNow:([self next] - RAND_MAX / 2) % (SECONDS_IN_DAY * days)];
}

+ (NSDate *)dateWithRange:(NSTimeInterval)range {
    return [NSDate dateWithTimeIntervalSinceNow:-[self next] % (long long)range];
}

#pragma mark - Numbers

+ (float)floatInRange:(NSRange)range {
    float base = [self next] / (float)RAND_MAX;
    
    return base * range.length + range.location;
}

+ (int)intInRange:(NSRange)range {
    return [self next] % range.length + range.location;
}

+ (BOOL)boolean {
    return [self next] % 2 == 1;
}

+ (NSNumber *)nFloatInRange:(NSRange)range {
    return @([self floatInRange:range]);
}

+ (NSNumber *)nIntInRange:(NSRange)range {
    return @([self intInRange:range]);
}

+ (NSNumber *)nBoolean {
    return @([self boolean]);
}

#pragma mark - Strings

#define kParagraphSize 50

+ (NSString *)lipsumWithWords:(NSInteger)wordCount newlines:(BOOL)nl {
    NSInteger offset = [self next] % lipsumBody.count;
    NSInteger lastNewline = 0;
    NSMutableString *result = [NSMutableString string];
    
    while (wordCount-->0) {
        [result appendString:lipsumBody[offset++ % lipsumBody.count]];
        [result appendString:(nl && lastNewline > kParagraphSize ? @"\n" : @" ")];
        
        if (lastNewline > kParagraphSize)
            lastNewline = 0;
        else
            lastNewline++;
    }
    
    return [result copy];
}

+ (NSString *)numberWithLength:(NSInteger)length {
    NSMutableString *ret = [NSMutableString string];
    
    while (length--> 0) {
        [ret appendFormat:@"%d",abs([self intInRange:NSMakeRange(0, 10)])];
    }
    
    return [ret copy];
}

@end
