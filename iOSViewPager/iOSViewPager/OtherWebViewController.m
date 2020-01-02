//
//  OtherWebViewController.m
//  iOSViewPager
//
//  Created by techfun on 2020/01/02.
//  Copyright © 2020 Naw Su Su Nyein. All rights reserved.
//

#import "OtherWebViewController.h"
#import <WebKit/WebKit.h>

@interface OtherWebViewController()
@property (weak, nonatomic) IBOutlet UILabel *lblSubLink;

@end

@implementation OtherWebViewController
-(void) viewDidLoad{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:true];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
@end
