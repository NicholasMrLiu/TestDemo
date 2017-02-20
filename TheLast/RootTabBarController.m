//
//  RootTabBarController.m
//  ManMao
//
//  Created by 周智勇 on 16/3/14.
//  Copyright © 2016年 Tuse. All rights reserved.
//

#import "RootTabBarController.h"
//#import "ShopCarViewController.h"
//#import "MemberCenterViewController.h"
//#import "HomePageViewController.h"
#import "MainNavigationController.h"
#import "HomeMainNavController.h"
//#import "TeamViewController.h"
//#import "DianPuViewController.h"
//#import "MemberCenterVC.h"
//
//#import "CoustominterfaceVC.h"
#import "HomeViewController.h"
#import "MyteamViewController.h"
#import "ShopCarViewController.h"
#import "MemberViewController.h"

#import "UMMobClick/MobClick.h"
@interface RootTabBarController ()<UITabBarControllerDelegate>

@property (nonatomic, assign) BOOL supportPortraitOnly;
@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    [self addChildControllers];
    
//    [self ConversionController];
}


- (void)addChildControllers{
    
    HomeViewController * homeVC = [[HomeViewController alloc] init];
    [self addChildVC:homeVC vcTitle:@"" tabBarItemTitle:@"首页" image:@"shouye" selectedImage:@"shouyeD"];
    
    MyteamViewController * teamVC = [[MyteamViewController alloc] init];
    [self addChildVC:teamVC vcTitle:@"我的团队" tabBarItemTitle:@"我的团队" image:@"tuandui" selectedImage:@"tuanduiD"];
    
    ShopCarViewController * shopVC = [[ShopCarViewController alloc] init];
    [self addChildVC:shopVC vcTitle:@"购物车" tabBarItemTitle:@"购物车" image:@"gouwu" selectedImage:@"gouwuD"];
    
    MemberViewController * memberCenterVC = [[MemberViewController alloc] init];
    [self addChildVC:memberCenterVC vcTitle:@"会员中心" tabBarItemTitle:@"会员中心" image:@"gerenCenter" selectedImage:@"gerenCenterD"];
    
 
    
}

-(void)addChildVC:(UIViewController *)childVC vcTitle:(NSString *)vcTitle tabBarItemTitle:(NSString *)tabBarItemTitle image:(NSString *)image selectedImage:(NSString *)selectedImage{
    childVC.title = vcTitle;
    childVC.tabBarItem.title = tabBarItemTitle;
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//保证图片点击之后不变颜色
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:3];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10], NSForegroundColorAttributeName : MM_APPBaseColor} forState:UIControlStateSelected];//设置文字选中时的颜色UIControlStateSelected
     [self addChildViewController:childVC];
    
    //    if ([image isEqualToString:@"shouye"]) {//指定某个特定的页面用这个基类的NavController
//        HomeMainNavController * mainVC = [[HomeMainNavController alloc] initWithRootViewController:childVC];
//        mainVC.navigationBar.translucent = NO;
//        [self addChildViewController:mainVC];
//    }else{
////
//    }
}

//转换控制器
- (void)ConversionController{
        //        改变TabarItem的图片和文字
        MyteamViewController * dianpuVC = [[MyteamViewController alloc] init];
        MainNavigationController * navVC = [[MainNavigationController alloc] initWithRootViewController:dianpuVC];
        navVC.tabBarItem.image =[[UIImage imageNamed:@"yun"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        navVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"yunD"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        navVC.tabBarItem.title =@"运营中心";
        dianpuVC.title = @"运营中心";
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    self.index = self.selectedIndex;
}

#pragma mark --
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
        return [self.viewControllers.lastObject supportedInterfaceOrientations];
    }
}

- (BOOL)shouldAutorotate {
    if (self.supportPortraitOnly) {
        return NO;
    }else{
        return [self.viewControllers.lastObject shouldAutorotate];
    }
}


@end

