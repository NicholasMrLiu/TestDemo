//
//  DrawerViewController.h
//  ManMao
//
//  Created by 周智勇 on 16/2/14.
//  Copyright © 2016年 Tuse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootTabBarController.h"
@interface DrawerViewController : UIViewController
@property (nonatomic, strong)RootTabBarController* homeVC;
@property (nonatomic, strong)UIViewController * rightVC;


//声明一个初始化方法
- (id)initWithHomeVC:(UIViewController *)homeVC
                rightVC:(UIViewController *)rightVC;

//打开抽屉方法
- (void)openDrawer;

//关闭抽屉方法
- (void)closeDrawer;

@end
