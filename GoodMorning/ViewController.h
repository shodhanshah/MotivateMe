//
//  ViewController.h
//  GoodMorning
//
//  Created by Shodhan Shah on 9/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import <Social/Social.h>
#import "SSFavoriteViewDelegate.h"
#import "SSArchiveFavorites.h"
//#import <iAd/iAd.h>

@interface ViewController : UIViewController 
#pragma mark properties
@property (strong, nonatomic) IBOutlet UIImageView *BackGround;
@property (strong, nonatomic) IBOutlet UILabel *quoteLable;

@property (strong, nonatomic) NSDictionary *quoteDictionary;
@property (strong, nonatomic) NSDictionary *BGSetsDictionary;

@property (strong, nonatomic)  NSString *todayEndDigit;
@property (strong, nonatomic)  NSString *todayQuote;
#pragma mark Favorite Properties

@property(strong, nonatomic) SSArchiveFavorites *archiveData;
@property(strong, nonatomic) NSMutableArray *favoriteQuotes;

@property(strong,nonatomic) UITableView  *MyTableView;

@property (strong, nonatomic) SSFavoriteViewDelegate *myDelegate;


@property(strong, nonatomic) UINavigationController *myNavigationController;

@property(strong, nonatomic) UIViewController *initialController;

// added lately


@property(strong, nonatomic) UIAlertView * alert;
@property(strong, nonatomic) NSString * shareString;
@property(strong, nonatomic) NSURL * shareUrl;
@property(strong, nonatomic) NSArray *myActivityItems;
@property(strong, nonatomic) UIActivityViewController *myActivityViewController;

@property(strong, nonatomic) UIAlertView *statusAlert;

#pragma mark IBAction
- (IBAction)TouchAndHold:(UIImageView *)sender;
- (IBAction)TouchDownShare:(UIButton *)sender;

- (IBAction)showFavoritePopUp:(UIButton *)sender;


#pragma mark HelperMethods
-(NSString *) getTodayImage;

//#pragma mark iAdBanner
//@property (nonatomic)    IBOutlet ADBannerView *topAdBanner;
//
//@property (nonatomic) BOOL bannerIsVisible;
\
@end
