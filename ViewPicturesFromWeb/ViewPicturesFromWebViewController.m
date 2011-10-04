//
//  ViewPicturesFromWebViewController.m
//  ViewPicturesFromWeb
//
//  Created by Michael Dautermann on 10/3/11.
//  Copyright 2011 Try To Guess My Company Name. All rights reserved.
//

#import "ViewPicturesFromWebViewController.h"
#import "ViewOnePictureFromWebViewController.h"
#import "ViewPicturesFromWebAppDelegate.h"

@implementation ViewPicturesFromWebViewController

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Picture Management

- (UIImage *) fetchPhotoFromThumbnailURL: (NSURL *) urlToFetchFrom
{
    NSError * error = NULL;
    NSData * dataForThumbnail = [[NSData alloc] initWithContentsOfURL: urlToFetchFrom options: 0 error: &error];
    UIImage * imageToReturn = NULL;
    
    if(error)
    {
        NSLog( @"error in fetching from %@ - %d %@ %@", [urlToFetchFrom absoluteString], [error code], [error domain], [error localizedDescription] );
    } else {
        imageToReturn = [UIImage imageWithData: dataForThumbnail];
        [dataForThumbnail release];  // if I were compiling for iOS 5, we could ARC this
    }
    return(imageToReturn);
}

- (void)reloadThisTableViewCell: (NSArray *) singleIndexPathArray
{
    [pictureTableView beginUpdates];
    [pictureTableView reloadRowsAtIndexPaths: singleIndexPathArray withRowAnimation:UITableViewRowAnimationFade];
    [pictureTableView endUpdates];    
}

- (void)preparePhotos
{
    NSAutoreleasePool * thePool = [[NSAutoreleasePool alloc] init];
    NSUInteger rowCount = 0;

    // we're loading the pictures in order...
    for(NSDictionary * pictureEntry in arrayOfPictures)
    {
        UIImage * image = [self fetchPhotoFromThumbnailURL: [NSURL URLWithString:[pictureEntry objectForKey: @"thumbnailURL"]]];
        if(image)
        {
            NSArray * visibleIndexPaths = [pictureTableView indexPathsForVisibleRows];
            NSUInteger sectionRow[2] = {0, rowCount++};
            NSIndexPath * indexPathForThisThumbnail = [NSIndexPath indexPathWithIndexes: sectionRow length:2];
            
            [arrayOfThumbnails addObject: image]; 
            
            if([visibleIndexPaths indexOfObjectIdenticalTo: indexPathForThisThumbnail] != NSNotFound)
            {
                // can only do U.I. things on the main thread
                [self performSelectorOnMainThread: @selector(reloadThisTableViewCell:) withObject: [NSArray arrayWithObject: indexPathForThisThumbnail] waitUntilDone: NO];
            }
        } else {
            // and if the picture load fails, add a question mark
            [arrayOfThumbnails addObject: [UIImage imageNamed: @"QuestionMark"]];
        }
    }
    
    [thePool drain];
}

- (void)loadPictureArray
{
    // if we already previously loaded the picture array, release it
    if(arrayOfPictures)
    {
        [arrayOfPictures release];
        arrayOfPictures = NULL;
    }
    
    // another way to automatically release/retain would be to set arrayOfPictures as an Objective C 2.0 property
    // and then do self.array = an array we created
    arrayOfPictures = [[NSArray alloc] initWithContentsOfURL: [NSURL URLWithString: @"https://orby.orb.com/~jregisser/download/iOSTest/images.plist"]];
    if(!arrayOfPictures || ([arrayOfPictures count] == 0))
    {
        NSBundle * mainBundle = [NSBundle mainBundle];
        NSURL * urlForImagePlist = [mainBundle URLForResource: @"images" withExtension: @"plist"];
        
        if(urlForImagePlist)
        {
            // in case jregisser pulls his plist file, here's a local copy of the same file
            arrayOfPictures = [[NSArray alloc] initWithContentsOfURL: urlForImagePlist];
        } else {
            NSLog( @"could not load image plist!");
        }
    }
    if(arrayOfPictures && ([arrayOfPictures count] > 0))
    {
        arrayOfThumbnails = [[NSMutableArray alloc] initWithCapacity: [arrayOfPictures count]];
        [NSThread detachNewThreadSelector: @selector(preparePhotos) toTarget:self withObject:NULL];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self loadPictureArray];
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [arrayOfPictures release];
    [arrayOfThumbnails release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table stuff
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // only one section for our table
    return([arrayOfPictures count]);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* CellIdentifier = @"PictureCell";    
    UITableViewCell * ourCell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    NSDictionary * pictureEntry = [arrayOfPictures objectAtIndex: indexPath.row];

    if(ourCell == NULL)
    {
        ourCell = [[[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier] autorelease];
    }
    
    if(ourCell)
    {
        if([arrayOfThumbnails count] > indexPath.row)
        {
            UIImage * image = [arrayOfThumbnails objectAtIndex: indexPath.row];
            if(image)
                ourCell.imageView.image = image;
        }
        ourCell.textLabel.text = [pictureEntry objectForKey: @"title"];
    }
    
    return(ourCell);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * pictureEntry = [arrayOfPictures objectAtIndex: indexPath.row];
    if(pictureEntry)
    {
        NSString * fullSizePictureURL = [pictureEntry objectForKey: @"url"];
        
        // if there's a valid object for the "url" key...
        if(fullSizePictureURL && ([fullSizePictureURL length] > 0))
        {
            ViewPicturesFromWebAppDelegate * appDelegate = (ViewPicturesFromWebAppDelegate *)[[UIApplication sharedApplication] delegate];
            UINavigationController * navigationController = appDelegate.navigationController;
            ViewOnePictureFromWebViewController * bigPictureView = [[ViewOnePictureFromWebViewController alloc] initWithNibName: @"ViewOnePictureFromWebViewController" bundle: nil];
            if(bigPictureView)
            {
                NSString * pictureTitle = [pictureEntry objectForKey: @"title"];
                NSString * pictureCaption = [pictureEntry objectForKey: @"caption"];
                NSURLRequest * urlRequest = [[NSURLRequest alloc] initWithURL: [NSURL URLWithString: fullSizePictureURL] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:3.0];
                if(pictureTitle)
                {
                    bigPictureView.pictureTitle = pictureTitle;
                } else {
                    bigPictureView.pictureTitle = @""; // in case there is no "title" in this entry's dictionary
                }
                [navigationController pushViewController: bigPictureView animated: YES];
                if(pictureCaption)
                {
                    // only show the caption if there is one in the picture entry
                    bigPictureView.pictureCaption.text = pictureCaption;
                    [bigPictureView.pictureCaption setHidden: NO];
                }
                [bigPictureView.webView loadRequest: urlRequest];
                [bigPictureView release];
            }
        }
    }
}


@end
