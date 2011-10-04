//
//  ViewPicturesFromWebViewController.h
//  ViewPicturesFromWeb
//
//  Created by Michael Dautermann on 10/3/11.
//  Copyright 2011 Try To Guess My Company Name. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewPicturesFromWebViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UITableView * pictureTableView;
    
    NSArray * arrayOfPictures;
    NSMutableArray * arrayOfThumbnails;
}

@end
