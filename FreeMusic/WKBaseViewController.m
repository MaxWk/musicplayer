

#import "WKBaseViewController.h"
@interface WKBaseViewController ()

@end

@implementation WKBaseViewController
@synthesize navigation = _navigation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString * systeam = [UIDevice currentDevice].systemVersion;
    float number = [systeam floatValue];
    
    CGFloat height = 0.0f;
    NSInteger type = 0;
    if (number <= 6.9) {
        type = 0;
        height = 44.0f;
    }else{
        type = 1;
        height = 66.0f;
    }
    
    globle = [Globle shareGloble];
    
    self.navigation = [[ZZNavigationView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
    _navigation.type = type;
    _navigation.leftImage  = [UIImage imageNamed:@"nav_backbtn.png"];
    _navigation.delegate = self;
    _navigation.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_navigation];

	// Do any additional setup after loading the view.
}

#pragma mark ##### ZZNavigationViewDelegate ####
-(void)previousToViewController
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightButtonClickEvent
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
