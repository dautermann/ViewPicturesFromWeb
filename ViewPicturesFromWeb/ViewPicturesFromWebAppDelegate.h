//
//  ViewPicturesFromWebAppDelegate.h
//  ViewPicturesFromWeb
//
//  Created by Michael Dautermann on 10/3/11.
//  Copyright 2011 Try To Guess My Company Name. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewPicturesFromWebViewController;

@interface ViewPicturesFromWebAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) IBOutlet ViewPicturesFromWebViewController *viewController;

@end
