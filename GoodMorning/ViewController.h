//
//  ViewController.h
//  GoodMorning
//
//  Created by Jatin Shah on 9/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import <Social/Social.h>

@interface ViewController : UIViewController
#pragma mark properties
@property (weak, nonatomic) IBOutlet UIImageView *BackGround;
@property (weak, nonatomic) IBOutlet UILabel *quoteLable;
@property (strong, nonatomic) NSMutableArray *quoteArray;
@property (strong, nonatomic) NSDictionary *quoteDictionary;
@property (strong, nonatomic) NSDictionary *BGSetsDictionary;
@property (strong, nonatomic)  NSString *dateString;


#pragma mark IBAction
- (IBAction)TouchAndHold:(UIImageView *)sender;
- (IBAction)TouchDownShare:(UIButton *)sender;

#pragma mark HelperMethods
-(NSString *) getTodayImage;



\
@end
