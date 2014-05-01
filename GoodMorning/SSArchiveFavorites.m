//
//  SSArchiveFavorites.m
//  MotivateMe
//
//  Created by Shodhan Shah on 1/22/14.
//
//

#import "SSArchiveFavorites.h"

@implementation SSArchiveFavorites
#pragma mark NSCoding methods
// file path to store and retrieve data.
- (NSString *) getPath
{
    NSString* path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSLog(@"path:::%@",path);
    return [path stringByAppendingPathComponent:@"MyFile.dat"];
}

// save an array
- (void) saveSettingsData: (NSMutableArray*)data
{
    [NSKeyedArchiver archiveRootObject:data toFile:[self getPath]];
}

// get that array back
- (NSMutableArray *) loadSavedData
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self getPath]];
}


@end
