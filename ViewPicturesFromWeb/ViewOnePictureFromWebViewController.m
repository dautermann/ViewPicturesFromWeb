//
//  ViewOnePictureFromWebViewController.m
//  ViewPicturesFromWeb
//
//  Created by Michael Dautermann on 10/4/11.
//  Copyright 2011 Try To Guess My Company Name. All rights reserved.
//

#import "ViewOnePictureFromWebViewController.h"

@implementation ViewOnePictureFromWebViewController

@synthesize webView;
@synthesize pictureCaption;
@synthesize pictureTitle;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void) viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = pictureTitle;
    if([pictureCaption.text length] > 0)
    {
        [pictureCaption setHidden: NO];
    }
    [super viewWillAppear: animated];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
