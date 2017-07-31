//
//  DZAboutViewController.m
//  Music
//
//  Created by dengwei on 16/1/2.
//  Copyright (c) 2016年 dengwei. All rights reserved.
//

#import "WKAboutViewController.h"
#import "WKLeftViewController.h"
#import "WKMainViewController.h"
#import "WKHomeViewController.h"
@interface WKAboutViewController ()<WKLeftViewDelegate,ZZNavigationViewDelegate>

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) WKLeftViewController *leftViewController;


@end

@implementation WKAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigation.rightImage = nil;
    self.navigation.leftImage  =[UIImage imageNamed:@"Home_Icon_Highlight"];

    self.navigation.title = @"关于";
    self.navigation.navigaionBackColor = [UIColor colorWithRed:0.0f/255.0f green:136.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    [self.view addGestureRecognizer:swipe];

    [self setupUI];
    [self fillContent];
}

-(void)setupUI
{
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, SCREEN_HEIGHT)];
    textView.backgroundColor = [UIColor whiteColor];
    self.title = @"About";
    textView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"aboutBackground"]];
    [self.view addSubview:textView];
    self.textView = textView;
    self.textView.userInteractionEnabled = NO;
    
    leftViewLeftFrame = CGRectMake(-kMainWidth, 0, kViewWidth, kViewHeight);
    leftViewRightFrame = CGRectMake(self.view.x,CGRectGetMaxY(self.navigation.frame)-44, self.view.width/2, self.view.height);
    self.leftViewController = [[WKLeftViewController alloc] init];
    self.leftViewController.delegate = self;
    self.leftViewController.view.frame = leftViewLeftFrame;
    [self.view addSubview:self.leftViewController.view];
}

-(void)fillContent
{
    self.textView.text = @"音乐播放器\n实现本地音乐播放，具有后台操作功能。\n\n\n联系方式：610379995@qq.com\n软件作者：万康";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - DZLeftViewDelegate methods
- (void)showHomeView{
    WKMainViewController *Online = [[WKMainViewController alloc]init];
    [self.leftViewController.view becomeFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.leftViewController.view.frame = leftViewLeftFrame;
        [self.navigationController pushViewController:Online animated:YES];
    }];
}

- (void)showOnlineMusicView{
    WKHomeViewController *local = [[WKHomeViewController alloc]init];
    [self.leftViewController.view becomeFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.leftViewController.view.frame = leftViewLeftFrame;
        [self.navigationController pushViewController:local animated:YES];
    }];
}

- (void)showAboutView{
    [self.leftViewController.view becomeFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.leftViewController.view.frame = leftViewLeftFrame;
    }];
}

-(void)previousToViewController
{
    [self showLeftView];
}
-(void)showLeftView{
    [self.leftViewController.view becomeFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.leftViewController.view.frame = leftViewRightFrame;
    }];
}
- (void)swipe:(UISwipeGestureRecognizer *)recognizer{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [self showLeftView];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:[touch view]];
    if (!CGRectContainsPoint(leftViewRightFrame, point)) {
        [UIView animateWithDuration:0.3 animations:^{
            self.leftViewController.view.frame = leftViewLeftFrame;
            _textView.alpha = 1;
        }];
    }
    
}

@end
