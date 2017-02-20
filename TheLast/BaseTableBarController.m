//
//  BaseTableBarController.m
//  ManMao
//
//  Created by 周智勇 on 16/3/14.
//  Copyright © 2016年 Tuse. All rights reserved.
//

#import "BaseTableBarController.h"
#import "XBTabBar.h"

@interface BaseTableBarController ()
@property (nonatomic, strong) UIView * backView;
@end

@implementation BaseTableBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    XBTabBar *myTabBar = [[XBTabBar alloc] init];
    [self setValue:myTabBar forKey:@"tabBar"];
    
    
}

- (id)init{
    if ([super init]) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews{
    self.backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kUIScreenWidth/4, kTabBarHeight)];
//    _backView.backgroundColor = RGBColor(222,173,41);
    [self.tabBar insertSubview:_backView atIndex:0];
}

-(void)setIndex:(NSInteger)index{
    _index = index;
   [UIView animateWithDuration:.1 animations:^{
       _backView.frame = CGRectMake(index * kUIScreenWidth/4, 0, kUIScreenWidth/4, kNavigationBarHeight);
   }];
}





@end
