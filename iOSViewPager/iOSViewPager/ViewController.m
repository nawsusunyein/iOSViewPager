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
    self.webUrlLinks = @[@"https://www.google.com",@"https://www.facebook.com",@"https://www.gmail.com"];
    NSArray *data = @[@"News News News News News News News New40",@"キャンペーンキャンペーン キャンペーン キャンペーン キャンペーン キャンペ40",@"閲覧履歴 閲覧履歴 閲覧履歴 閲覧履歴 閲覧履歴 閲覧履歴 閲覧履歴 閲覧履歴40"];
    [self setTabData:data];
}

- (UIViewController *)viewPager:(UIViewController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    WebViewController *controller = [[WebViewController alloc]init:index link:self.webUrlLinks[index]];
    
    return controller;
}


@end
