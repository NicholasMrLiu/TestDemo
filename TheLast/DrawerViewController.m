//
//  DrawerViewController.m
//  ManMao
//
//  Created by 周智勇 on 16/2/14.
//  Copyright © 2016年 Tuse. All rights reserved.
//

#import "DrawerViewController.h"
//#import "RightViewController.h"
#import "RootTabBarController.h"
@interface DrawerViewController ()
@property (nonatomic, assign) BOOL supportPortraitOnly;

@end

@implementation DrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加右边视图 和 中间主视图
    self.homeVC.view.frame = self.view.bounds;
    [self.view addSubview:_homeVC.view];
    
    self.rightVC.view.frame = CGRectMake(kUIScreenWidth, 0, 72, kUIScreenHeight);
    [self.view addSubview:_rightVC.view];
}

- (id)initWithHomeVC:(UIViewController *)homeVC rightVC:(UIViewController *)rightVC {
    if (self = [super init]) {
        self.homeVC = homeVC;
        self.rightVC = rightVC;
        [self addChildViewController:_homeVC];
        [self addChildViewController:_rightVC];
    }
    return self;
}

- (void)openDrawer {
    CGRect rightRect = self.rightVC.view.frame;
    CGRect homeRect = self.homeVC.view.frame;
    rightRect.origin = CGPointMake(kUIScreenWidth - 72, 0);
    homeRect.origin = CGPointMake(-72, 0);
    
    //设置过渡动画
    //防止循环引用的出现
    __weak typeof(self)mySelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        mySelf.rightVC.view.frame = rightRect;
        mySelf.homeVC.view.frame = homeRect;
    }];
}

- (void)closeDrawer {
    CGRect rightRect = self.rightVC.view.frame;
    CGRect homeRect = self.homeVC.view.frame;
    rightRect.origin = CGPointMake(kUIScreenWidth, 0);
    homeRect.origin = CGPointMake(0, 0);

    //设置过渡动画
    //防止循环引用的出现
    __weak typeof (self)mySelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        mySelf.rightVC.view.frame = rightRect;
        mySelf.homeVC.view.frame = homeRect;
    }];
}

#pragma mark -- 这个地方不写，播放页面的每一个相关方法都不会走
#warning 如果只是支持某一个页面的横屏，那么久必须在工程中勾选横屏。而且要在每一层都要重写一下方法。就是告诉它我再哪些页面横屏了。其余没说明的都不横屏！！！！！！比如在这里说明self.childViewControllers[0]就是主的控制器支持横屏。但是.然后在RootTabarController中说明了之后self.viewControllers.lastObject才支持之前选中的方向。最后在MainNavController中说明了只有PlayViewController才支持所有方向。最终，只有DrawerViewController中的RootTabbarController的MainnavController的PlayViewController才支持项目中勾选的所有方向。其他的全部仅仅支持竖屏！！！
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if (self.supportPortraitOnly) {
        return UIInterfaceOrientationPortrait == toInterfaceOrientation;
    }else {
        return [self shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.supportPortraitOnly) {
        return UIInterfaceOrientationMaskPortrait;
    }else{
        return [self.childViewControllers[0] supportedInterfaceOrientations];
    }
}


- (BOOL)shouldAutorotate {
    if (self.supportPortraitOnly) {
        return NO;
    }else{
        return [self.childViewControllers[0] shouldAutorotate];
    }
}


@end
