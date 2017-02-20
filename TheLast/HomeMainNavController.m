//
//  HomeMainNavController.m
//  ManMao
//
//  Created by 周智勇 on 16/2/15.
//  Copyright © 2016年 Tuse. All rights reserved.
//

#import "HomeMainNavController.h"
#import "AppDelegate.h"
//#import "DrawerViewController.h"
#import "HomeViewController.h"
//#import "RemindWindow.h"

@interface HomeMainNavController ()<UIAlertViewDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong)UIButton * rightTopBtn;
@property (nonatomic, strong)UIButton * covertBtn;
@end

@implementation HomeMainNavController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self setNavigationBarTheme];
    [self setNavigationItemTheme];
}

-(UIButton *)rightTopBtn{
    if (_rightTopBtn == nil) {
        self.rightTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightTopBtn.frame = CGRectMake(0, 0, 30, 30);
        [_rightTopBtn addTarget:self action:@selector(homeRightTopBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightTopBtn;
}

- (void)setNavigationItemTheme{
    UIBarButtonItem * barIetm = [UIBarButtonItem appearance];
    NSMutableDictionary * textAttributes = [NSMutableDictionary dictionary];
    textAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    textAttributes[NSForegroundColorAttributeName] = MM_APPBaseColor;
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
#pragma mark --
//- (void)homeRightTopBtnClicked{
//    UIWindow * window =[UIApplication sharedApplication].keyWindow;
//    DrawerViewController * drawer = (DrawerViewController *)window.rootViewController;
//    BOOL isFirstTap = [SingleTon shareSingleTon].isFirstTap;
//    if (!isFirstTap) {
//        [_rightTopBtn setImage:[UIImage imageNamed:@"guanbi"] forState:UIControlStateNormal];
//        [drawer openDrawer];
//        [window addSubview:self.covertBtn];
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isFirstTap"];
//    }
//}

#pragma mark --
- (UIButton *)covertBtn{
    if (_covertBtn == nil) {
        self.covertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.covertBtn.frame = CGRectMake(0, 0, kUIScreenWidth - 70, kUIScreenHeight);
        [self.covertBtn addTarget:self action:@selector(covertBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _covertBtn;
}

//- (void)covertBtnClicked{
//    UIWindow * window =[UIApplication sharedApplication].keyWindow;
//    DrawerViewController * drawer = (DrawerViewController *)window.rootViewController;
//    [drawer closeDrawer];
//    [self.covertBtn removeFromSuperview];
//    [SingleTon shareSingleTon].isFirstTap = NO;
//}

////
-(void)viewWillAppear:(BOOL)animated{
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

- (void)navigationController:(UINavigationController *)navController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navController.viewControllers.count > 1)
    {
        [UIView animateWithDuration:0.5f animations:^{
            self.tabBarController.tabBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 49);
        }];
    }
    else
    {
        [UIView animateWithDuration:0.5f  animations:^{
            self.tabBarController.tabBar.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 49, [UIScreen mainScreen].bounds.size.width, 49);
        }];
    }
    
}




@end
