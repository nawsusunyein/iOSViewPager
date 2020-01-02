//
//  OtherWebViewController.m
//  iOSViewPager
//
//  Created by techfun on 2020/01/02.
//  Copyright © 2020 Naw Su Su Nyein. All rights reserved.
//

#import "OtherWebViewController.h"
#import <WebKit/WebKit.h>

@interface OtherWebViewController()<WKUIDelegate,WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet WKWebView *subWebView;


@end

@implementation OtherWebViewController
-(void) viewDidLoad{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self setUpWebView];
    [self setURLRequest:self.urlString];
}

-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:true];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void) setUpWebView{
    self.subWebView.navigationDelegate = self;
    self.subWebView.UIDelegate = self;
}

-(void) setURLRequest : (NSString *) requestUrlString{
    NSURL *url = [[NSURL alloc] initWithString: requestUrlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url
                                                  cachePolicy: NSURLRequestUseProtocolCachePolicy
                                              timeoutInterval: 5];
    [self.subWebView loadRequest: request];
}
@end
