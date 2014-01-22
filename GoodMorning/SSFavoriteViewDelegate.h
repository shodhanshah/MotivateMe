//
//  SSFavoriteViewDelegate.h
//  MotivateMe
//
//  Created by Shodhan Shah on 1/21/14.
//
//

#import <Foundation/Foundation.h>
#import "SSArchiveFavorites.h"

@interface SSFavoriteViewDelegate : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic)  NSMutableArray *savedQuotesToView;
@property (strong,nonatomic) UITableView *favoriteQuotesView;

- (void)loadview:(UITableView *) mytblView favoriteTextArray:(NSMutableArray *)savedQuotes;

@property(strong,nonatomic) SSArchiveFavorites *dataArchiver;
@end
