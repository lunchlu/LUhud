//
//
//
//
//  Created by luchanghao on 16/12/7.
//  Copyright © 2016年 luchanghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EPProgressType) {
    ProgressType_none = 0,
    ProgressType_title,     //只显示文字
    ProgressType_hud,       //菊花
    ProgressType_success,   //成功图片
    ProgressType_fault,     //成功失败
    ProgressType_view       //自定义图片
};


/**
    《《《《 同一时间只能显示一个弹框view 》》》》
 */
@class EPHUDview;
@interface EPHUDManager : NSObject

/**
 屏幕弹框，先是在屏幕中间，显示一句话
 sec:   手动设置显示时间，默认为2s
 title: 显示的文字
 superview : 设置显示的父控件，默认显示在屏幕
 */
+(void)showTitle:(NSString *)title;
+(void)showTitle:(NSString *)title hideAfter:(CGFloat)sec;
+(void)showTitle:(NSString *)title InSuperview:(UIView *)superview ;
+(void)showTitle:(NSString *)title InSuperview:(UIView *)superview hideAfter:(CGFloat)sec;

/**
 屏幕弹框，先是在屏幕中间，显示菊花
 sec:   手动设置显示时间，默认为2s
 title: 显示的文字
 superview : 设置显示的父控件，默认显示在屏幕
 */
+(void)showHUD:(NSString *)title;
+(void)showHUD:(NSString *)title hideAfter:(CGFloat)sec;
+(void)showHUD:(NSString *)title InSuperview:(UIView *)superview ;
+(void)showHUD:(NSString *)title InSuperview:(UIView *)superview hideAfter:(CGFloat)sec;

/**
 屏幕弹框，先是在屏幕中间，显示成功的图片和文字
 sec:   手动设置显示时间，默认为2s
 title: 显示的文字
 superview : 设置显示的父控件，默认显示在屏幕
 */
+(void)showSuccessTitle:(NSString *)title;
+(void)showSuccessTitle:(NSString *)title hideAfter:(CGFloat)sec;
+(void)showSuccessTitle:(NSString *)title InSuperview:(UIView *)superview;
+(void)showSuccessTitle:(NSString *)title InSuperview:(UIView *)superview hideAfter:(CGFloat)sec;

/**
 屏幕弹框，先是在屏幕中间，显示失败的图片和文字
 sec:   手动设置显示时间，默认为2s
 title: 显示的文字
 superview : 设置显示的父控件，默认显示在屏幕
 */
+(void)showFaultTitle:(NSString *)title;
+(void)showFaultTitle:(NSString *)title hideAfter:(CGFloat)sec;
+(void)showFaultTitle:(NSString *)title InSuperview:(UIView *)superview;
+(void)showFaultTitle:(NSString *)title InSuperview:(UIView *)superview hideAfter:(CGFloat)sec;

/**
 屏幕弹框，先是在屏幕中间，显示自定义设置的图片
 sec:   手动设置显示时间，默认为2s
 title: 显示的文字
 superview : 设置显示的父控件，默认显示在屏幕
 */
+(void)showView:(UIView *)view;
+(void)showView:(UIView *)view hideAfter:(CGFloat)sec;
+(void)showView:(UIView *)view InSuperview:(UIView *)superview;
+(void)showView:(UIView *)view InSuperview:(UIView *)superview hideAfter:(CGFloat)sec;

/**
 手动隐藏显示的图片
 需要持续显示图片不消失时，《《《设置sec的秒数为MAXFLOAT》》》
 再调用dismiss方法，手动消失
 */
+(void)dismiss;

/**
 Private Function
 用于EPHUDview的计算作用
 私有方法，用于计算的工具
 */
+(CGRect)getViewFrameWith:(EPProgressType)type Title:(NSString *)title Superview:(UIView *)superview;
@end







/**
 实例方法调用
 EPHUDview *view = [[EPHUDview alloc]init];
 [view showTitle:@"qwer" InSuperview:self.containview];
 显示在superview的中间
 */
@interface EPHUDview :UIView

//自定义宽高
@property (nonatomic, assign) CGFloat hudWidth;
@property (nonatomic, assign) CGFloat hudHeight;

/**
 父控件中间显示一句话
 */
-(void)showTitle:(NSString *)title InSuperview:(UIView *)superview ;
-(void)showTitle:(NSString *)title InSuperview:(UIView *)superview hideAfter:(CGFloat)sec;

/**
 父控件中间显示菊花
 */
-(void)showHUD:(NSString *)title InSuperview:(UIView *)superview ;
-(void)showHUD:(NSString *)title InSuperview:(UIView *)superview hideAfter:(CGFloat)sec;

/**
 父控件中间显示成功图片和一句话
 */
-(void)showSuccessTitle:(NSString *)title InSuperview:(UIView *)superview;
-(void)showSuccessTitle:(NSString *)title InSuperview:(UIView *)superview hideAfter:(CGFloat)sec;

/**
 父控件中间显示成功失败和一句话
 */
-(void)showFaultTitle:(NSString *)title InSuperview:(UIView *)superview;
-(void)showFaultTitle:(NSString *)title InSuperview:(UIView *)superview hideAfter:(CGFloat)sec;

/**
 父控件中间显示自定义view
 */
-(void)showView:(UIView *)view InSuperview:(UIView *)superview;
-(void)showView:(UIView *)view InSuperview:(UIView *)superview hideAfter:(CGFloat)sec;

/**
 手动隐藏显示的图片
 需要持续显示图片不消失时，《《《设置sec的秒数为MAXFLOAT》》》
 再调用dismiss方法，手动消失
 */
-(void)dismiss;
@end



