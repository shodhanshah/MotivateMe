//
//  ViewController.m
//  GoodMorning
//
//  Created by Shodhan Shah on 9/15/13.
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
    
    _favoriteQuotes=[[NSMutableArray alloc]init];
    _archiveData=[[SSArchiveFavorites alloc]init];
    
    if([_archiveData loadSavedData] !=nil){
        
        NSLog(@"saved data is not nill");
        
        _favoriteQuotes=[_archiveData loadSavedData];
        
        
    }
   // load quotes and BGSets dictionary from plist
    NSString *QuoteFile = [[NSBundle mainBundle] pathForResource:@"QuoteList" ofType:@"plist"];
    self.quoteDictionary = [[NSDictionary alloc] initWithContentsOfFile:QuoteFile];

    
    NSString *BGImagesFile = [[NSBundle mainBundle] pathForResource:@"BGSets" ofType:@"plist"];
    self.BGSetsDictionary = [[NSDictionary alloc] initWithContentsOfFile:BGImagesFile];
    
 // format todays date  to extract last digit
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd"];
    self.todayEndDigit = [dateFormat stringFromDate:today];
    self.todayEndDigit =[_todayEndDigit substringFromIndex:[_todayEndDigit length] -1 ]  ;
    
    
    // set today's image as Background
    NSString *BGImageName=[self getTodayImage];
    UIImage *img = [UIImage imageNamed:BGImageName];
    [self.BackGround setImage:img];
    
    NSLog(@"BG image loaded.");

     _todayQuote=self.quoteDictionary[self.todayEndDigit];
    
  // Add iAdBanner
    _adBanner = [[ADBannerView alloc] initWithFrame:CGRectZero];
    
    _adBanner.frame = CGRectOffset(_adBanner.frame, 0, self.view.frame.size.height-_adBanner.frame.size.height);
    
    [_adBanner setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    _adBanner.delegate=self;
    [_adBanner setAlpha:0];
    
    [self.view addSubview:_adBanner];
    
    self.bannerIsVisible=NO;
    
    NSLog(@"view did load..");
    
    
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
    self.alert = [[UIAlertView alloc] initWithTitle:@"Manage Favorites" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add to favorites", @"Show favorites", nil];
 //   [alert show];
    
    
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
    
  //   _todayQuote=self.quoteDictionary[self.todayEndDigit];
    
    if (sender.state == UIGestureRecognizerStateBegan           ) {
       self.quoteLable.alpha=0;
        self.quoteLable.text=_todayQuote;
        
        [UIView animateWithDuration:2.0
                         animations:^{
                             self.quoteLable.alpha = 1.0;   // fade out
                             self.BackGround.alpha=0.3;
                         }
                         completion:^(BOOL finished){
                         }];
        
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        
        [UIView animateWithDuration:3.0
                         animations:^{
                             self.quoteLable.alpha = 0.0;   // fade out
                             
                             self.BackGround.alpha=1.0;
                         }
                         completion:^(BOOL finished){
                         }];
        
    }
}

- (IBAction)TouchDownShare:(id)sender {
    
   _shareString = _todayQuote;
    _shareUrl = [NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id875145071"];
    
    _myActivityItems = [NSArray arrayWithObjects:_shareUrl, _shareString, nil];
    
    _myActivityViewController = [[UIActivityViewController alloc] initWithActivityItems:_myActivityItems applicationActivities:nil];
    
    _myActivityViewController.excludedActivityTypes=		 @[UIActivityTypePrint , UIActivityTypeCopyToPasteboard, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList];
    
    _myActivityViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:_myActivityViewController animated:YES completion:nil];
}

- (NSString *)getTodayImage {
    NSString* todayImage= [[ NSString alloc] init];
    NSEnumerator *enumerator = [self.BGSetsDictionary  keyEnumerator];
    NSString *key;
    
    while ((key = [enumerator nextObject])) {
        
        NSArray* daysForKey = [key  componentsSeparatedByString: @","];
        if([daysForKey containsObject:(_todayEndDigit)]){
            todayImage=_BGSetsDictionary[key];
            
        }
    }
    return todayImage;
    
}





- (IBAction)showFavoritePopUp:(UIButton *)sender {
    [self viewWillAppear:YES];
    [self.alert show];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Add to favorites"])
    {
        
        if(![_favoriteQuotes containsObject:_todayQuote]){
            
        [_favoriteQuotes addObject:_todayQuote];
            
        }
        [_archiveData saveSettingsData:_favoriteQuotes];
    //  faded dialog
        
        [self showStatus:@"✅ Added to favorites." timeout:1];
        
    }
    else if([title isEqualToString:@"Show favorites"])
    {
        
        //      Make instance of tableview  standalone/independent
        _MyTableView = [[UITableView alloc] initWithFrame:self.view.bounds ];
        
        // Instantiate custom delegate standalone class
        SSFavoriteViewDelegate *delegateClass = [[SSFavoriteViewDelegate alloc] init];
        // assign to property to avoid bad memory access.
        [self setMyDelegate:delegateClass];
        
        
        // set delegate and data source of table view to custom standalone class.
        [_MyTableView  setDelegate:self.myDelegate];
        [_MyTableView setDataSource:self.myDelegate];
        // we need to reload data from delegate
        
        
        [self.myDelegate loadview:_MyTableView  favoriteTextArray:_favoriteQuotes  ];
        //  show table view by adding as subview to any view controller's view.
        
        _initialController = [[UIViewController alloc] initWithNibName:@"initialController" bundle:nil];
        
        
        _initialController.navigationItem.title = @"My Favorites";
        
        
        
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                       style:UIBarButtonItemStylePlain target:self action:@selector(goback) ];
        _initialController.navigationItem.leftBarButtonItem = backButton;
        
        _initialController.navigationItem.rightBarButtonItem = self.editButtonItem;
        _initialController.view =_MyTableView;
        
        
        [self setEditing:NO animated:YES];
        
        _myNavigationController = [[UINavigationController alloc]initWithRootViewController:_initialController];
        
        [self.view addSubview:_myNavigationController.view];
        //    [self.view addSubview:_initialController.view];
        
    }
    
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [_MyTableView setEditing:editing animated:YES];
    if (editing == YES){
        // Change views to edit mode.
 //       NSLog(@"in edit mode");
    }
    else {
        // Save the changes if needed and change the views to noneditable.
  //      NSLog(@"in non edit mode");
    }
}

- (void)goback
{
    [_myNavigationController.view removeFromSuperview];
    //   [_initialController.view removeFromSuperview];
    
}

- (void)showStatus:(NSString *)message timeout:(double)timeout {
    _statusAlert = [[UIAlertView alloc] initWithTitle:nil
                                             message:message
                                            delegate:nil
                                   cancelButtonTitle:nil
                                   otherButtonTitles:nil];
    [_statusAlert show];
    [NSTimer scheduledTimerWithTimeInterval:timeout
                                     target:self
                                   selector:@selector(timerExpired:)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)timerExpired:(NSTimer *)timer {
    [_statusAlert dismissWithClickedButtonIndex:0 animated:YES];
}


//#pragma iAdBanner


#pragma mark - AdViewDelegates

-(void)bannerView:(ADBannerView *)banner
didFailToReceiveAdWithError:(NSError *)error{
    NSLog(@"Error loading");
    if (self.bannerIsVisible)
    {
    [UIView beginAnimations:@"animateAdBannerOn" context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:0];
    [UIView commitAnimations];
    self.bannerIsVisible = NO;
    }
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad loaded");
    
    if (!self.bannerIsVisible)
    {
    [UIView beginAnimations:@"animateAdBannerOn" context:nil];
    [UIView setAnimationDuration:1];
    [banner setAlpha:1];
    [UIView commitAnimations];
    self.bannerIsVisible = YES;
    }
}
-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
    NSLog(@"Ad will load");
}
-(void)bannerViewActionDidFinish:(ADBannerView *)banner{
    NSLog(@"Ad did finish");
}

@end
