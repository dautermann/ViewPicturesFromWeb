//
//  ViewOnePictureFromWebViewController.h
//  ViewPicturesFromWeb
//
//  Created by Michael Dautermann on 10/4/11.
//  Copyright 2011 Try To Guess My Company Name. All rights reserved.
//



@interface ViewOnePictureFromWebViewController : UIViewController
{
    IBOutlet UIWebView * webView;
    IBOutlet UILabel * pictureCaption;
    NSString * pictureTitle;

}

@property (nonatomic, readonly) UIWebView * webView;
@property (nonatomic, retain) UILabel * pictureCaption;
@property (nonatomic, retain) NSString * pictureTitle;

@end
