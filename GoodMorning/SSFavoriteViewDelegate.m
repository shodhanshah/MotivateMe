//
//  SSFavoriteViewDelegate.m
//  MotivateMe
//
//  Created by Shodhan Shah on 1/21/14.
//
//

#import "SSFavoriteViewDelegate.h"

@implementation SSFavoriteViewDelegate

- (void)loadview:(UITableView *)tableView favoriteTextArray:(NSMutableArray *)favoritetexts
{
    _favoriteQuotesView=tableView;
    _savedQuotesToView=favoritetexts;
    [tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_savedQuotesToView count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //Where we configure the cell in each row
    //   NSLog(@"cellForRowAtIndexPath.....%ld",(long)indexPath.row);
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell;
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell... setting the text of our cell's label
    cell.textLabel.text = [_savedQuotesToView objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"didSelectRowAtIndexPath.....,%ld",(long)indexPath.row);
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;

}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If row is deleted, remove it from the list.
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //    SimpleEditableListAppDelegate *controller = (SimpleEditableListAppDelegate *)[[UIApplication sharedApplication] delegate];
        //       [ removeObjectFromListAtIndex:indexPath.row];
        
        [_favoriteQuotesView beginUpdates];
        
        [_favoriteQuotesView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [_savedQuotesToView removeObjectAtIndex:indexPath.row];
        [_favoriteQuotesView endUpdates];
        [self loadview:_favoriteQuotesView favoriteTextArray:_savedQuotesToView];
        
        _dataArchiver= [[SSArchiveFavorites alloc]init];
        
        [_dataArchiver saveSettingsData:_savedQuotesToView];

        
    }
}

@end
