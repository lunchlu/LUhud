

#import "ViewController.h"
#import "EPHUDManager.h"
#define COLOR_Random \
[UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

@interface ViewController ()
@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIView *showview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.containView = [[UIView alloc] initWithFrame:(CGRectMake(0, 100, 400 , 200))];
    [self.view addSubview: _containView];
    _containView.backgroundColor = [UIColor whiteColor];
    
    
    self.showview = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, 100, 100))];
    _showview.backgroundColor = [UIColor greenColor];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:(CGRectMake(0, 50, 50, 50))];
    btn.backgroundColor = COLOR_Random;
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:(CGRectMake(50, 50, 50, 50))];
    btn1.backgroundColor = COLOR_Random;
    [self.view addSubview:btn1];
    [btn1 addTarget:self action:@selector(btnClick1) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:(CGRectMake(100, 50, 50, 50))];
    btn2.backgroundColor = COLOR_Random;
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(btnClick2) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:(CGRectMake(150, 50, 50, 50))];
    btn3.backgroundColor = COLOR_Random;
    [self.view addSubview:btn3];
    [btn3 addTarget:self action:@selector(btnClick3) forControlEvents:(UIControlEventTouchUpInside)];
    ////////////////////////////////
    
    UIButton *btn4 = [[UIButton alloc] initWithFrame:(CGRectMake(0, 350, 50, 50))];
    btn4.backgroundColor = COLOR_Random;
    [self.view addSubview:btn4];
    [btn4 addTarget:self action:@selector(btnClick4) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *btn5 = [[UIButton alloc] initWithFrame:(CGRectMake(50, 350, 50, 50))];
    btn5.backgroundColor = COLOR_Random;
    [self.view addSubview:btn5];
    [btn5 addTarget:self action:@selector(btnClick5) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *btn6 = [[UIButton alloc] initWithFrame:(CGRectMake(100, 350, 50, 50))];
    btn6.backgroundColor = COLOR_Random;
    [self.view addSubview:btn6];
    [btn6 addTarget:self action:@selector(btnClick6) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *btn7 = [[UIButton alloc] initWithFrame:(CGRectMake(150, 350, 50, 50))];
    btn7.backgroundColor = COLOR_Random;
    [self.view addSubview:btn7];
    [btn7 addTarget:self action:@selector(btnClick7) forControlEvents:(UIControlEventTouchUpInside)];
    
}

-(void)btnClick{
    EPHUDview *view = [[EPHUDview alloc] init];
    [view showTitle:@"sdsfeef des" InSuperview:_containView hideAfter:MAXFLOAT];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [view dismiss];
    });
}

-(void)btnClick1{
    EPHUDview *view = [[EPHUDview alloc] init];
    [view showHUD:@"dffdff" InSuperview:_containView hideAfter:6];
}

-(void)btnClick2{
    EPHUDview *view = [[EPHUDview alloc] init];
    [view showSuccessTitle:@"des" InSuperview:_containView hideAfter:4];
}

-(void)btnClick3{
    EPHUDview *view = [[EPHUDview alloc] init];
    [view showFaultTitle:@"1213232" InSuperview:_containView];
}

-(void)btnClick4{
    [EPHUDManager showTitle:@"jsof jsf jfje"];
}

-(void)btnClick5{
    [EPHUDManager showHUD :@"jsof jsf jfje"];
}

-(void)btnClick6{
    [EPHUDManager showSuccessTitle:@"jsof jsf jfje"];
}

-(void)btnClick7{
    [EPHUDManager showView:_showview];
}

@end











