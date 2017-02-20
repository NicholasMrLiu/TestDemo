//
//  MainViewController.m
//  ManMao
//
//  Created by 周智勇 on 16/2/14.
//  Copyright © 2016年 Tuse. All rights reserved.
//

#import "MainNavigationController.h"
//#import "LoginViewController.h"
//#import "RemindWindow.h"
@interface MainNavigationController ()<UIAlertViewDelegate,UINavigationControllerDelegate>
@property (nonatomic, assign) BOOL supportPortraitOnly;
@end

@implementation MainNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    
    self.supportPortraitOnly = NO;
    [self setNavigationBarTheme];
    [self setNavigationItemTheme];
}

- (void)setNavigationItemTheme{
    UIBarButtonItem * barIetm = [UIBarButtonItem appearance];
    NSMutableDictionary * textAttributes = [NSMutableDictionary dictionary];
    textAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    textAttributes[NSForegroundColorAttributeName] = MM_APPBaseColor;//设置导航栏颜色
    [barIetm setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
}

- (void)setNavigationBarTheme{//设置导航栏相关属性
    UINavigationBar * navBar = [UINavigationBar appearance];// 取出设置主题的对象
    [navBar setBarTintColor:[UIColor whiteColor]];
    // 设置导航栏标题颜色
    NSMutableDictionary *textAttributes = [NSMutableDictionary dictionary];
    textAttributes[NSForegroundColorAttributeName] = MM_APPBaseColor;
    textAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [navBar setTitleTextAttributes:textAttributes];
    
    // 5.去除阴影
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowOffset = CGSizeZero;
    textAttributes[NSShadowAttributeName] = shadow;
    
}

-(void)popself
{
    [self.view endEditing:YES];
    [self popViewControllerAnimated:YES];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 0){
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Main_back"] style:UIBarButtonItemStylePlain target:self action:@selector(popself)];
        backItem.tintColor = MM_APPBaseColor;
        viewController.navigationItem.leftBarButtonItem = backItem;
    }
    self.interactivePopGestureRecognizer.delegate = (id)self;
    
    [super pushViewController:viewController animated:animated];
}

//
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shited) name:@"shit" object:nil];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"shit" object:nil];
}

//- (void)shited{
//    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//    [[RemindWindow shareRemindWindow] popRemindWindow:self];
//}


//优酷视频

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if (self.supportPortraitOnly) {
        return UIInterfaceOrientationPortrait == toInterfaceOrientation;
    }else {
        return [self.topViewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
    }
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.supportPortraitOnly) {
        return UIInterfaceOrientationMaskPortrait;
    }else{
        return [self.topViewController supportedInterfaceOrientations];
    }
}



- (void)navigationController:(UINavigationController *)navController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navController.viewControllers.count > 0)
    {
        [UIView animateWithDuration:0.5f animations:^{
            self.tabBarController.tabBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 49);
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5f animations:^{
            self.tabBarController.tabBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 49, [UIScreen mainScreen].bounds.size.width, 49);
        }];
    }
}


@end
