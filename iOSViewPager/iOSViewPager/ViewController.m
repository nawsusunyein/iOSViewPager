//
//  ViewController.m
//  iOSViewPager
//
//  Created by techfun on 2019/12/30.
//  Copyright © 2019 Naw Su Su Nyein. All rights reserved.
//

#import "ViewController.h"
#import "PagerViewController.h"
#import "WebViewController.h"

@interface ViewController ()<ViewPagerDataSource>
@property (nonatomic,strong) NSArray *webUrlLinks;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = self;
    NSString *campaign = @"キャンペーン";
    NSLog(@"campaign count %lu",(unsigned long)campaign.length);
    
    self.webUrlLinks = @[@"https://www.google.com",@"https://www.facebook.com",@"https://www.yahoo.com",@"https://www.google.com",@"https://www.facebook.com",@"https://www.yahoo.com",@"https://www.google.com",@"https://www.facebook.com"];
    NSArray *data = @[@"News",@"キャンペーン",@"閲覧履歴",@"ランキング",@"新着",@"TSC",@"White",@"UL"];
    [self setTabData:data];
    // Do any additional setup after loading the view.
}

- (UIViewController *)viewPager:(UIViewController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    WebViewController *controller = [[WebViewController alloc]init:index link:self.webUrlLinks[index]];
    
    return controller;
}


@end
