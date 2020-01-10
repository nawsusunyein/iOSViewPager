//
//  OtherTwoWebViewController.m
//  iOSViewPager
//
//  Created by techfun on 2020/01/10.
//  Copyright © 2020 Naw Su Su Nyein. All rights reserved.
//


#import <WebKit/WebKit.h>
#import "OtherTwoWebViewController.h"
#import "OtherWebViewController.h"

@interface OtherTwoWebViewController()<WKUIDelegate,WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet WKWebView *otherWebTwoView;



@end

@implementation OtherTwoWebViewController
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
    self.otherWebTwoView.navigationDelegate = self;
    self.otherWebTwoView.UIDelegate = self;
    self.otherWebTwoView.allowsBackForwardNavigationGestures = YES;
}

-(void) setURLRequest : (NSString *) requestUrlString{
    NSURL *url = [[NSURL alloc] initWithString: requestUrlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL: url
                                                  cachePolicy: NSURLRequestUseProtocolCachePolicy
                                              timeoutInterval: 5];
    [self.otherWebTwoView loadRequest: request];
}

#pragma mark - WKNavigationDelegate Methods
/// ページ遷移前にアクセスを許可
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"アクセスURL：%@", navigationAction.request.URL.absoluteString);
    if(navigationAction.navigationType == UIWebViewNavigationTypeLinkClicked){
        NSLog(@"here entered");
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        OtherWebViewController *otherWebViewController = (OtherWebViewController *)[storyboard instantiateViewControllerWithIdentifier:@"OtherWebViewController"];
        //OtherWebViewController *otherWebViewController = [[OtherWebViewController alloc] init];
        otherWebViewController.urlString = navigationAction.request.URL.absoluteString;
        [self.navigationController pushViewController:otherWebViewController animated:YES];
        decisionHandler(WKNavigationActionPolicyCancel);
      
        
    }else{
        // どのページも許可
        decisionHandler(WKNavigationActionPolicyAllow);
        NSLog(@"アクセスURL：%@", navigationAction.request.URL.absoluteString);
    }
}

// 読み込み開始
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"読み込み開始");
}

// 読み込み完了
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"読み込み完了");
}

// 読み込み失敗
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"読み込み失敗");
}

// 接続失敗
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"エラーコード：%ld", (long)error.code);
}

@end
