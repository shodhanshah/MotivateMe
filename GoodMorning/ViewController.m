//
//  ViewController.m
//  GoodMorning
//
//  Created by Jatin Shah on 9/15/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //Load Dictionary with wood name cross refference values for image name
    NSString *plistQuotePath = [[NSBundle mainBundle] pathForResource:@"QuoteList" ofType:@"plist"];
    self.quoteDictionary = [[NSDictionary alloc] initWithContentsOfFile:plistQuotePath];

    
    NSString *pListBGSetPath = [[NSBundle mainBundle] pathForResource:@"BGSets" ofType:@"plist"];
    self.BGSetsDictionary = [[NSDictionary alloc] initWithContentsOfFile:pListBGSetPath];
    
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd"];
    self.dateString = [dateFormat stringFromDate:today];
    self.dateString =[_dateString substringFromIndex:[_dateString length] -1 ]  ;
    
    NSLog(@"%@",self.dateString);
    
//    UIImage *img1 = [UIImage imageNamed:@"sunrise.jpg"];
//    [self.BackGround setImage:img1];
    
    NSString *BGImage=[self getTodayImage];
    UIImage *img = [UIImage imageNamed:BGImage];
    [self.BackGround setImage:img];
}

- (void)viewDidUnload
{
    [self setBackGround:nil];
    [self setQuoteLable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



    
- (IBAction)TouchAndHold:(UILongPressGestureRecognizer*)sender {
    
    NSString *todayQuote=self.quoteDictionary[self.dateString];
    
    if (sender.state == UIGestureRecognizerStateBegan           ) {
       self.quoteLable.alpha=0;
        self.quoteLable.text=todayQuote;
        
        [UIView animateWithDuration:3.0
                         animations:^{
                             self.quoteLable.alpha = 1.0;   // fade out
                             self.BackGround.alpha=0.3;
                         }
                         completion:^(BOOL finished){
                         }];
        
        NSLog(@"Long press Began Ended");
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        
        [UIView animateWithDuration:3.0
                         animations:^{
                             self.quoteLable.alpha = 0.0;   // fade out
                             
                             self.BackGround.alpha=1.0;
                         }
                         completion:^(BOOL finished){
                         }];
        
        NSLog(@"Long press end Ended");
    }
}

- (IBAction)TouchDownShare:(id)sender {
     NSLog(@"Share touch down:");
    
  //  if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]){
//        NSLog(@"Serviceavailable:1");
//        SLComposeViewController *facebookPost=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
//        NSLog(@"Serviceavailable:2");
//        [facebookPost setInitialText:@"Share with friends"];
//        
//        NSLog(@"Serviceavailable:3");
//        [self presentViewController:facebookPost animated:YES completion:Nil];
//        
//        NSLog(@"Serviceavailable");
 //   }

//    UIImage *imgShare = [UIImage imageNamed:@"buttonImage_1.png"];
//    NSArray *activityItems = @[imgShare, @"textToShare"];
//    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
//    //Here is how to exclude some types like Twitter if not applicable
//    activityVC.excludedActivityTypes = @[ UIActivityTypePrint, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll];
//    [self presentViewController:activityVC animated:YES completion:nil];
    
   NSString *shareString = @"Share with friends, \n http://itunes.apple.com/us/app/id284417350?mt=8";
 //   UIImage *shareImage = [UIImage imageNamed:@"buttonImage_1.jpg"];
    NSURL *shareUrl = [NSURL URLWithString:@"http://itunes.apple.com/us/app/id284417350?mt=8"];
    
//    NSArray *activityItems = [NSString *UIActivityTypePostToFacebook];
    
    NSArray *myActivityItems = [NSArray arrayWithObjects:shareUrl, shareString, nil];
    
    UIActivityViewController *myActivityViewController = [[UIActivityViewController alloc] initWithActivityItems:myActivityItems applicationActivities:nil];
    
    myActivityViewController.excludedActivityTypes=		 @[UIActivityTypePrint , UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList];
    
    
    
    myActivityViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:myActivityViewController animated:YES completion:nil];
    
    
    
    
}

- (NSString *)getTodayImage {
    NSString* todayImage= [[ NSString alloc] init];
    NSEnumerator *enumerator = [self.BGSetsDictionary  keyEnumerator];
    NSString *key;
    
    while ((key = [enumerator nextObject])) {
        
        NSArray* daysForKey = [key  componentsSeparatedByString: @","];
        if([daysForKey containsObject:(_dateString)]){
            todayImage=_BGSetsDictionary[key];
            
        }
    }
    return todayImage;
    
}

@end
