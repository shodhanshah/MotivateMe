//
//  SSArchiveFavorites.h
//  MotivateMe
//
//  Created by Shodhan Shah on 1/22/14.
//
//

#import <Foundation/Foundation.h>

@interface SSArchiveFavorites : NSObject
- (NSString *) getPath;
- (void) saveSettingsData: (NSMutableArray*)data;
- (NSMutableArray *) loadSavedData;





@end
