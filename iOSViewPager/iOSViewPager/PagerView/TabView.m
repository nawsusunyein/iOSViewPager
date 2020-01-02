//
//  TabView.m
//  ViewPager
//
//  Created by liu zheng on 15/7/27.
//  Copyright (c) 2015年 liu zheng. All rights reserved.
//

#import "TabView.h"
@interface TabView ()

@property (strong,nonatomic) NSString * text;
@property (strong,nonatomic) UILabel *label;
@property (nonatomic) CGSize textSize;
@property (strong,nonatomic) UIFont *font;
@end



@implementation TabView

- (id)initWithFrame:(CGRect)frame text:(NSString *) text textSize:(CGSize) textSize  font:(UIFont *) font {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.text = text;
        self.textSize = textSize;
        self.font = font;
    }
    return self;
}

-(CGSize) getSize {
    return self.textSize;
}

- (void) layoutSubviews{

    if(!_label){
        CGRect frame;
        NSUInteger bottomLineHeight = 2;
        if(self.text.length > 20){
            frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - bottomLineHeight);
        }else{
           frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - bottomLineHeight);
        }
       
        _label = [[UILabel alloc]initWithFrame:frame];
         _label.backgroundColor = [UIColor clearColor];
        [_label setFont:[UIFont systemFontOfSize:14]];
        [self setColor];
        
        _label.lineBreakMode = NSLineBreakByWordWrapping;
        _label.numberOfLines = 0;
        _label.text = self.text;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:_label];
    }
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    [self setColor];
    [self setNeedsDisplay];
}


-(void) setColor {
    if (_selected) {
        _label.textColor = [UIColor yellowColor];
    } else {
        _label.textColor = [UIColor colorWithRed:255/255 green: 255/255 blue: 255/255 alpha: 1];
    }
}


@end


