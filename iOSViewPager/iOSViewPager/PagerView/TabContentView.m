//
//  TabContentView.m
//  ViewPager
//
//  Created by liu zheng on 15/7/29.
//  Copyright (c) 2015年 liu zheng. All rights reserved.
//
#define TabSpan  20
#define TabWidth  50
#define TabHeight  80

#import "TabContentView.h"
#import "TabView.h"

@interface TabContentView()
@property (nonatomic) CGRect initFrame;

@end


@implementation TabContentView

- (id)initWithFrame:(CGRect)frame tabData:(NSArray *) tabData {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _tabData = tabData;
        _initFrame = frame;
    }
    return self;
}


-(void) setupTabs {
    
    _activeTabIndex =0;
    _lastTabIndex = 0;
    
    NSUInteger count = self.tabData.count;
    
    if(!self.tabs){
        self.tabs = [NSMutableArray arrayWithCapacity:count];
    }
    [self.tabs removeAllObjects];
    
    NSInteger contentSize = TabSpan;
    NSUInteger xp = TabSpan;
    
    NSLog(@"Device width : %@",@(self.frame.size.width));
    
    NSUInteger tabWidth = 0;
    NSUInteger tabItemWidth = 0;
    BOOL isFortyCharacter = NO;
    
    for(int i=0; i<count; i++){
        NSString *text = [self.tabData objectAtIndex:i];
        NSUInteger characterCount = [text length];
        NSLog(@"character count %@",@(characterCount));
        if(characterCount == 40){
            isFortyCharacter = YES;
        }
        tabWidth += characterCount * 12;

    }
    
    if(tabWidth <= self.frame.size.width/2){
        tabItemWidth = (self.frame.size.width / self.tabData.count);
    }else{
        if(count < 2){
            tabItemWidth = self.frame.size.width;
        }else if(count == 2){
            tabItemWidth = self.frame.size.width / 2;
        }else{
            if(isFortyCharacter){
                tabItemWidth = 150;
            }else{
               tabItemWidth = 120;
            }
            
        }
    }
    
    for (int i=0; i<count; i++) {
        
        NSString *text = [self.tabData objectAtIndex:i];
        
        UIFont *font = [UIFont systemFontOfSize:12.0];
        CGSize textSize = [text sizeWithAttributes:@{NSFontAttributeName :font}];
        CGRect frame;
        
        if(i == 0){
            frame = CGRectMake(0, 0, tabItemWidth + 10, TabHeight);
        }else{
            frame = CGRectMake(xp, 0, tabItemWidth + 10, TabHeight);
        }
        
        if(i == 0){
            xp += tabItemWidth;
            contentSize += tabItemWidth;
        }else if(i == count - 1){
            xp += tabItemWidth;
            contentSize += tabItemWidth + 10;
        }else{
            xp += tabItemWidth + TabSpan;
            contentSize += tabItemWidth + TabSpan;
        }
        
        
        TabView *subTab = [[TabView alloc]initWithFrame:frame text:text textSize:textSize font:font];
        
        if (i==0) {
            [subTab setSelected:YES];
            if(!_lineView){
                CGRect lineFrame = CGRectMake(subTab.frame.origin.x,subTab.frame.size.height-3, subTab.frame.size.width,3);
                _lineView = [[UIView alloc] initWithFrame:lineFrame];
                _lineView.backgroundColor = [UIColor yellowColor];
                [self addSubview:_lineView];
            }
        }
        
        [self addSubview:subTab];
        
        // To capture tap events
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
        [subTab addGestureRecognizer:tapGestureRecognizer];
        
        
        [self.tabs addObject:subTab];
    }
    
    
    self.contentSize = CGSizeMake(contentSize, TabHeight);
}


#pragma mark - IBAction
- (IBAction)handleTapGesture:(id) sender {
    
    // Get the desired page's index
    UITapGestureRecognizer *tapGestureRecognizer = (UITapGestureRecognizer *)sender;
    UIView *tabView = tapGestureRecognizer.view;
    
    NSUInteger index = [self.tabs indexOfObject:tabView];
    
    if (self.activeTabIndex != index) {
        [self selectTabAtIndex:index];
        
        if([self.controllerDelegte respondsToSelector:@selector(setClickTabController:)]){
            [self.controllerDelegte setClickTabController:index];
        }
        
    }
}

- (void) selectTabAtIndex:(NSInteger) index {
    
    //lastTag
    _lastTabIndex = self.activeTabIndex;
    
    // Select the tab
    self.activeTabIndex = index;
    
    TabView *lastTabView = [self.tabs objectAtIndex:_lastTabIndex];
    [lastTabView setSelected:NO];
    
    TabView *tabView = [self.tabs objectAtIndex:index];
    [tabView setSelected:YES];
    
    [self moveTag];
}


-(void) moveTag {
    
    CGRect frame;
    
    if (self.lastTabIndex<self.activeTabIndex) {
        
        if (self.activeTabIndex>=self.tabData.count) {
            return;
        }
        
        TabView *tabView = [self.tabs objectAtIndex:self.activeTabIndex];
        if (tabView) {
            frame = tabView.frame;
            //center top
            frame.origin.x+=_initFrame.size.width/2 - TabSpan;
            if (frame.origin.x>=self.contentSize.width) {
                frame.origin.x = self.contentSize.width - tabView.frame.size.width;
            }
        }
    } else {
        NSInteger index = self.activeTabIndex;
        if (index<0) {
            index = 0;
        }
        TabView *tabView = [self.tabs objectAtIndex:index];
        frame = tabView.frame;
        //center top
        frame.origin.x -= _initFrame.size.width/2 - TabSpan;
        if(frame.origin.x<=0)
            frame.origin.x = 0;
    }
    
    [self scrollRectToVisible:frame animated:YES];
    [self moveTagLine];
}

-(void) moveTagLine{
    
    TabView *tabView = [self.tabs objectAtIndex:self.activeTabIndex];
    CGRect frame = tabView.frame;
    //line view height
    frame.origin.y = frame.size.height - 3;
    frame.size.height = 3;
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         [_lineView setFrame:frame];
                     }
                     completion:nil];
}


- (NSUInteger) getTabIndex {
    return _activeTabIndex;
}

- (NSUInteger) getLastTabIndex {
    return _lastTabIndex;
}

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *bezierPath;
    
    // Draw top line
    UIColor *color = [UIColor colorWithWhite:197.0/255.0 alpha:0.75];
    
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0.0, 0.0)];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(rect), 0.0)];
    [color setStroke];
    [bezierPath setLineWidth:1.0];
    [bezierPath stroke];
    
    // Draw bottom line
    bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(0.0, CGRectGetHeight(rect))];
    [bezierPath addLineToPoint:CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect))];
    [color setStroke];
    [bezierPath setLineWidth:1.0];
    [bezierPath stroke];

}



@end


