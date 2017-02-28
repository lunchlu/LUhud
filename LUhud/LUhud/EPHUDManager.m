//
//  EPProgressManager.m
//  EPProgressHUD
//
//  Created by luchanghao on 16/12/7.
//  Copyright © 2016年 luchanghao. All rights reserved.
//

#import "EPHUDManager.h"
#import "UIView+Frame.h"



#define MAIN_SCREEN ([UIScreen mainScreen].bounds)
//add screen's WIDTH and HEIGHT
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define NAVBAR_HEIGHT 64
#define TABBAR_HEIGHT 49

// 颜色(RGB)
#define COLOR_RGB(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define COLOR_RGBA(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define COLOR_HEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



@interface EPHUDview ()<CAAnimationDelegate>
@property (nonatomic, assign) EPProgressType type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, weak)   UIView *fatherView;
@property (nonatomic, assign) CGFloat during;
@property (nonatomic, strong) UIView *view;

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UIView *alphaView;

@property (nonatomic, strong) UIImageView *jiazaieIMG;
@property (nonatomic, strong) UIImageView *jiazaihuIMG;

@property (nonatomic, assign) BOOL isAnimating;
@end

@implementation EPHUDview

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 10;
        [self setup];
    }
    return self;
}

-(void)setup{
    
    self.alphaView = [[UIView alloc] init];
    _alphaView.backgroundColor = COLOR_HEX(0x000000);
    _alphaView.alpha = 0.5;
    _alphaView.layer.cornerRadius = 10;
    [self addSubview:_alphaView];
    
    
    self.titleLab = [UILabel new];
    [self addSubview:_titleLab];
    _titleLab.textAlignment = NSTextAlignmentCenter;
    _titleLab.font = [UIFont systemFontOfSize:12];
    _titleLab.textColor = COLOR_HEX(0xd3d3d3);
    
    self.img = [UIImageView new];
    _img.contentMode = 1;
    [self addSubview:_img];
    
    self.jiazaieIMG = [UIImageView new];
    [self addSubview: _jiazaieIMG];
    _jiazaieIMG.contentMode = 1;
    _jiazaieIMG.image = [UIImage imageNamed:@"EPJiazaie"];
    
    self.jiazaihuIMG = [UIImageView new];
    _jiazaihuIMG.contentMode = 1;
    [self addSubview:_jiazaihuIMG];
    _jiazaihuIMG.image = [UIImage imageNamed:@"EPJiazaihu"];
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
    animation.duration  = 0.8;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    [_jiazaihuIMG.layer addAnimation:animation forKey:nil];

}

-(void)showTitle:(NSString *)title InSuperview:(UIView *)superview{
    [self showTitle:title InSuperview:superview hideAfter:0];
}

-(void)showTitle:(NSString *)title InSuperview:(UIView *)superview hideAfter:(CGFloat)sec{
    self.frame = [EPHUDManager getViewFrameWith:ProgressType_title Title:title Superview:superview];
    self.type = ProgressType_title;
    self.title = title;
    self.fatherView = superview;
    self.during = sec;
    [self show];
}

-(void)showHUD:(NSString *)title InSuperview:(UIView *)superview{
    [self showHUD:title InSuperview:superview hideAfter:MAXFLOAT];
}

-(void)showHUD:(NSString *)title InSuperview:(UIView *)superview hideAfter:(CGFloat)sec{
    self.frame = [EPHUDManager getViewFrameWith:ProgressType_hud Title:title Superview:superview];
    self.type = ProgressType_hud;
    self.title = title;
    self.fatherView = superview;
    self.during = sec;
    [self show];
}

-(void)showSuccessTitle:(NSString *)title InSuperview:(UIView *)superview{
    [self showSuccessTitle:title InSuperview:superview hideAfter:0];
}

-(void)showSuccessTitle:(NSString *)title InSuperview:(UIView *)superview hideAfter:(CGFloat)sec{
    self.frame = [EPHUDManager getViewFrameWith:ProgressType_success Title:title Superview:superview];
    self.type = ProgressType_success;
    self.title = title;
    self.fatherView = superview;
    self.during = sec;
    [self show];
}

-(void)showFaultTitle:(NSString *)title InSuperview:(UIView *)superview{
    [self showFaultTitle:title InSuperview:superview hideAfter:0];
}

-(void)showFaultTitle:(NSString *)title InSuperview:(UIView *)superview hideAfter:(CGFloat)sec{
    self.frame = [EPHUDManager getViewFrameWith:ProgressType_fault Title:title Superview:superview];
    self.type = ProgressType_fault;
    self.title = title;
    self.fatherView = superview;
    self.during = sec;
    [self show];
}

-(void)showView:(UIView *)view InSuperview:(UIView *)superview{
    [self showView:view InSuperview:superview hideAfter:0];
}

-(void)showView:(UIView *)view InSuperview:(UIView *)superview hideAfter:(CGFloat)sec{
    CGPoint centerPoint;

    if (superview) {
        centerPoint = CGPointMake(superview.width*0.5, superview.height*0.5);
    }
    else{
        centerPoint = CGPointMake(SCREEN_WIDTH*0.5, SCREEN_HEIGHT*0.5);
    }
    
    UIView *v = [UIView new];
    v.width = view.width;
    v.height = view.height;
    v.center = centerPoint;
    CGRect frame = v.frame;
    self.frame = frame;
    view.frame = CGRectMake(0, 0, v.width, v.height);
    
    self.type = ProgressType_view;
    self.view = view;
    self.fatherView = superview;
    self.during = sec;
    [self show];
}

-(void)dismiss{
    [self.layer removeAllAnimations];
    
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"opacity"];
    ani.duration = 0.35;
    ani.toValue = @0;
    ani.fillMode=kCAFillModeForwards;
    ani.removedOnCompletion = NO;
    [self.layer addAnimation:ani forKey:@"dismiss"];
    
//    [UIView animateWithDuration:0.35 animations:^{
//        self.alpha = 0;
//    }completion:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
}

-(void)show{
    self.alpha = 0.01;
    [self.layer removeAllAnimations];
    _alphaView.hidden = NO;
    _alphaView.frame = self.bounds;
    
    if (_fatherView) {
        [self removeFromSuperview];
        [_fatherView addSubview:self];
        if (_type == ProgressType_hud) {
            _alphaView.frame = CGRectZero;
        }
    }
    else{
        [[UIApplication sharedApplication].keyWindow addSubview:self];
    }
    
    if (_during == 0) {
        _during = 2;
    }
    
    CABasicAnimation *ani = [CABasicAnimation animationWithKeyPath:@"opacity"];
    ani.delegate = self;
    ani.duration = 0.35;
    ani.toValue = @1;
    ani.fillMode=kCAFillModeForwards;
    ani.removedOnCompletion = NO;
    [self.layer addAnimation:ani forKey:@"show"];
    
    if (_during<MAXFLOAT) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_during * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismiss];
        });
    }
    
//    [UIView animateWithDuration:0.35 animations:^{
//        self.alpha = 1;
//    }completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.35 delay:_during options:UIViewAnimationOptionLayoutSubviews animations:^{
//            self.alpha = 0;
//        } completion:^(BOOL finished) {
//            [self removeFromSuperview];
//        }];
//    }];
}


#pragma mark - set/get
-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLab.text = title;
}

-(void)setView:(UIView *)view{
    [self hideAllSubview];
    _view = view;
    _view.hidden = NO;
    [self addSubview:view];
}

-(void)setType:(EPProgressType)type{
    _type = type;
    [self setFrameWith:type];
}

#pragma mark - 设置frame
-(void)setFrameWith:(EPProgressType)type{
    [self hideAllSubview];
    if (type == ProgressType_title) {
        [self frameWithType_title];
    }
    else if (type == ProgressType_hud){
        [self frameWithType_hud];
    }
    else if (type == ProgressType_success){
        [self frameWithType_success];
    }
    else if (type == ProgressType_fault){
        [self frameWithType_fault];
    }
}

-(void)frameWithType_title{
    _titleLab.hidden = NO;
    self.titleLab.frame = self.bounds;
}

-(void)frameWithType_hud{
    
    _jiazaieIMG.hidden = NO;
    _jiazaihuIMG.hidden = NO;
    
    _jiazaieIMG.frame = CGRectMake(0, 0, 40, 40);
    
    if (_hudWidth > 0 && _hudHeight >0) {
        _jiazaieIMG.frame = CGRectMake(0, 0, _hudWidth, _hudHeight);
    }
    
    _jiazaieIMG.center = CGPointMake(self.width*0.5, self.height *0.5);
    
    _jiazaihuIMG.frame = _jiazaieIMG.frame;
}

-(void)frameWithType_success{
    _img.hidden = NO;
    _titleLab.hidden = NO;
    
    _img.frame = CGRectMake(0, 10, 40, 40);
    _img.centerX = self.width*0.5;
    _img.image = [UIImage imageNamed:@"EPDuigou@3x"];
    self.titleLab.frame = CGRectMake(0, 0, self.width, 15);
    _titleLab.bottom = self.height - 10;
}

-(void)frameWithType_fault{
    _img.hidden = NO;
    _titleLab.hidden = NO;
    
    _img.frame = CGRectMake(0, 10, 40, 40);
    _img.centerX = self.width*0.5;
    _img.contentMode = 1;
    _img.image = [UIImage imageNamed:@"EPChahao@3x"];
    self.titleLab.frame = CGRectMake(0, 0, self.width, 15);
    _titleLab.bottom = self.height - 10;

}

-(void)hideAllSubview{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            view.hidden = YES;
        }
    }
}
@end




static EPHUDview *epHUDview;
@implementation EPHUDManager

+(void)dismiss{
    if (epHUDview) {
        [epHUDview dismiss];
    }
}

#pragma - mark title
+(void)showTitle:(NSString *)title{
    [self viewWithProgressType:ProgressType_title Title:title Superview:nil hideAfter:0];
}

+(void)showTitle:(NSString *)title hideAfter:(CGFloat)sec{
    [self viewWithProgressType:ProgressType_title Title:title Superview:nil hideAfter:sec];
}

+(void)showTitle:(NSString *)title InSuperview:(UIView *)superview{
    [self viewWithProgressType:ProgressType_title Title:title Superview:superview hideAfter:0];
}

+(void)showTitle:(NSString *)title InSuperview:(UIView *)superview hideAfter:(CGFloat)sec{
    [self viewWithProgressType:ProgressType_title Title:title Superview:superview hideAfter:sec];
}


#pragma - mark hud
+(void)showHUD:(NSString *)title{
    //[self viewWithProgressType:ProgressType_hud Title:title Superview:nil hideAfter:0];
    [self showHUD:title hideAfter:MAXFLOAT];
}

+(void)showHUD:(NSString *)title hideAfter:(CGFloat)sec{
    [self viewWithProgressType:ProgressType_hud Title:title Superview:nil hideAfter:sec];
}

+(void)showHUD:(NSString *)title InSuperview:(UIView *)superview{
    [self viewWithProgressType:ProgressType_hud Title:title Superview:superview hideAfter:0];
}

+(void)showHUD:(NSString *)title InSuperview:(UIView *)superview hideAfter:(CGFloat)sec{
    [self viewWithProgressType:ProgressType_hud Title:title Superview:superview hideAfter:sec];
}


#pragma - mark success
+(void)showSuccessTitle:(NSString *)title{
    [self viewWithProgressType:ProgressType_success Title:title Superview:nil hideAfter:0];
}

+(void)showSuccessTitle:(NSString *)title hideAfter:(CGFloat)sec{
    [self viewWithProgressType:ProgressType_success Title:title Superview:nil hideAfter:sec];
}

+(void)showSuccessTitle:(NSString *)title InSuperview:(UIView *)superview{
    [self viewWithProgressType:ProgressType_success Title:title Superview:superview hideAfter:0];
}

+(void)showSuccessTitle:(NSString *)title InSuperview:(UIView *)superview hideAfter:(CGFloat)sec{
    [self viewWithProgressType:ProgressType_success Title:title Superview:superview hideAfter:sec];
}

#pragma - mark Fault
+(void)showFaultTitle:(NSString *)title{
    [self viewWithProgressType:ProgressType_fault Title:title Superview:nil hideAfter:0];
}

+(void)showFaultTitle:(NSString *)title hideAfter:(CGFloat)sec{
    [self viewWithProgressType:ProgressType_fault Title:title Superview:nil hideAfter:sec];
}

+(void)showFaultTitle:(NSString *)title InSuperview:(UIView *)superview{
    [self viewWithProgressType:ProgressType_fault Title:title Superview:superview hideAfter:0];
}

+(void)showFaultTitle:(NSString *)title InSuperview:(UIView *)superview hideAfter:(CGFloat)sec{
    [self viewWithProgressType:ProgressType_fault Title:title Superview:superview hideAfter:sec];
}

#pragma - mark view
+(void)showView:(UIView *)view{
    [self viewWithProgressType:ProgressType_view view:view Superview:nil hideAfter:0];
}

+(void)showView:(UIView *)view hideAfter:(CGFloat)sec{
    [self viewWithProgressType:ProgressType_view view:view Superview:nil hideAfter:sec];
}

+(void)showView:(UIView *)view InSuperview:(UIView *)superview{
    [self viewWithProgressType:ProgressType_view view:view Superview:superview hideAfter:0];
}

+(void)showView:(UIView *)view InSuperview:(UIView *)superview hideAfter:(CGFloat)sec{
    [self viewWithProgressType:ProgressType_view view:view Superview:superview hideAfter:sec];
}

#pragma mark - 汇总
+(void)viewWithProgressType:(EPProgressType)type Title:(NSString *)title Superview:(UIView *)superview hideAfter:(CGFloat)sec{
    
    CGRect frame = [self getViewFrameWith:type Title:title Superview:superview];
    
    if (!epHUDview) {
        epHUDview =  [[EPHUDview alloc] init];
    }
    [epHUDview.layer removeAllAnimations];
    epHUDview.frame = frame;
    epHUDview.type = type;
    epHUDview.title = title;
    epHUDview.fatherView = superview;
    epHUDview.during = sec;
    [epHUDview show];
}

//专门处理自定义view的方法
+(void)viewWithProgressType:(EPProgressType)type view:(UIView *)view Superview:(UIView *)superview hideAfter:(CGFloat)sec{
    
    CGPoint centerPoint = [self centerPointWithSuperview:superview];
    UIView *v = [UIView new];
    v.width = view.width;
    v.height = view.height;
    v.center = centerPoint;
    CGRect frame = v.frame;

    view.frame = CGRectMake(0, 0, v.width, v.height);
    
    if (!epHUDview) {
        epHUDview =  [[EPHUDview alloc] initWithFrame:frame];
    }
    [epHUDview.layer removeAllAnimations];
    epHUDview.type = type;
    epHUDview.view = view;
    epHUDview.fatherView = superview;
    epHUDview.during = sec;
    [epHUDview show];
}

+(CGRect)getViewFrameWith:(EPProgressType)type Title:(NSString *)title Superview:(UIView *)superview{
    
    CGPoint centerPoint = [self centerPointWithSuperview:superview];
    CGFloat height = 0;
    CGFloat width = 0;
    
    CGFloat strWidth = [self widthWithTitle:title];
    if ((strWidth + 40) < SCREEN_WIDTH) {
        width = strWidth +40;
    }
    else{
        width = SCREEN_WIDTH-40;
    }
    if(type == ProgressType_title)
    {
        height = 40;
    }
    else if(type == ProgressType_success)
    {
        height = 232/3;
        if (width< 232.f/3) {
            width = 232.f/3;
        }
    }
    else if(type == ProgressType_fault)
    {
        height = 232/3;
        if (width< 232.f/3) {
            width = 232.f/3;
        }
    }
    else if(type == ProgressType_hud)
    {
        height = 232.f/3;
        width  = 232.f/3;
    }
    else if(type == ProgressType_none)
    {
        height = 40;
    }
    
    UIView *v = [UIView new];
    v.width = width;
    v.height = height;
    v.center = centerPoint;
    CGRect frame = v.frame;
    
    return frame;
}

//通过superview计算view的centerPoint
+(CGPoint)centerPointWithSuperview:(UIView *)superview{
    if (superview) {
        return CGPointMake(superview.width*0.5, superview.height*0.5);
    }
    return CGPointMake(SCREEN_WIDTH*0.5, SCREEN_HEIGHT*0.5);
}

//文字宽度
+(CGFloat)widthWithTitle:(NSString *)title{
    CGSize size = [title sizeWithAttributes:
                            @{
                                NSFontAttributeName: [UIFont systemFontOfSize:12],
                            }];
    return size.width;
}
@end




