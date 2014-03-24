//
//  WebViewController.h
//  iOS-UIWebView-Browser
//
//  Created by Pablo Eduardo Ojeda Vasco on 24/03/14.
//  Copyright (c) 2014 SpeakinBytes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UILabel *lbLoading;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnBack;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnStop;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnRefresh;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnForward;

- (void)loadRequestFromString:(NSString*)urlString;
- (void)updateButtons;

@end
