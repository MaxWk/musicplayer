

#import "WKMainViewController.h"
#import "WKMainTableViewCell.h"
#import "WKSingerSongListViewController.h"
#import "WKMusicViewController.h"
#import "WKHomeViewController.h"
#import "WKAboutViewController.h"
@interface WKMainViewController ()<ZZNavigationViewDelegate,WKLeftViewDelegate>
{
    NSMutableArray * array;
}

@property (nonatomic, strong) WKLeftViewController *leftViewController;

@end

@implementation WKMainViewController

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage"]];
    array = [NSMutableArray new];
    [self setUpNavigation];
    [self setUpSearchBar];
    [self setUpTableView];
    [self setUpLeftView];

    [ProgressHUD show:nil];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    [self.view addGestureRecognizer:swipeRight];
    
    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:0.01];

}
- (void)setUpNavigation
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigation.leftImage  =[UIImage imageNamed:@"Home_Icon_Highlight"];
    self.navigation.rightImage = [UIImage imageNamed:@"nav_music.png"];
    self.navigation.title = @"网络搜索";
    self.navigation.navigaionBackColor = [UIColor colorWithRed:0.0f/255.0f green:136.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
}

- (void)setUpSearchBar
{
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f,self.navigation.size.height+self.navigation.origin.y, self.view.size.width, 44.0f)];
    _searchBar.delegate =self;
    _searchBar.placeholder = @"搜索:歌手";
    _searchBar.showsCancelButton = YES;
    _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _searchBar.keyboardType = UIKeyboardTypeDefault;
    _searchBar.barTintColor = [UIColor colorWithRed:127/255.0 green:195/255.0 blue:255/255.0 alpha:1];
    for(id cc in [_searchBar.subviews[0] subviews]){
        if([cc isKindOfClass:[UIButton class]]){
            UIButton *btn = (UIButton *)cc;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setTitle:@"取消"  forState:UIControlStateNormal];
        }
    }
    
    [self.view addSubview:_searchBar];
}

- (void)setUpTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _searchBar.size.height+_searchBar.origin.y, self.view.size.width, self.view.size.height-self.navigation.size.height-self.searchBar.size.height) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.bounces = NO;
    [self.view addSubview:_tableView];
}
- (void)setUpLeftView
{
    leftViewLeftFrame = CGRectMake(-kMainWidth, 0, kViewWidth, kViewHeight);
    leftViewRightFrame = CGRectMake(0,CGRectGetMaxY(self.navigation.frame)-44, self.view.width/2, self.view.height);
    
    self.leftViewController = [[WKLeftViewController alloc] init];
    self.leftViewController.delegate = self;
    self.leftViewController.view.frame = leftViewLeftFrame;
    [self.view addSubview:self.leftViewController.view];
}
- (void)delayMethod
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        WKSingerModel * model = [WKSingerModel new];
        array = [model songList];
        dispatch_async(dispatch_get_main_queue(), ^{
            [ProgressHUD dismiss];
            [_tableView reloadData];
        });
    });
}

-(void)rightButtonClickEvent
{
    if (globle.isPlaying) {
        WKMusicViewController * pushController = [WKMusicViewController shareMusicViewController];
        [self.navigationController pushViewController:pushController animated:YES];
    }
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	[_searchBar resignFirstResponder];
    [self delayMethod];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // called when keyboard search button pressed
    [_searchBar resignFirstResponder];
    
    if ([array count]!=0) {
        [array removeAllObjects];
    }
    [ProgressHUD show:nil];
    [self getSingerData];
}

-(void)getSingerData
{
    WKSingerModel * model = [WKSingerModel new];
    array = [model itemWith:_searchBar.text];
    [_tableView reloadData];
    [ProgressHUD dismiss];
    if (array.count) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
     NSString * dentifier = @"cell";
        WKMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
     if (cell == nil) {
         cell = [[WKMainTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dentifier];
     }
     
     WKSingerModel * model = [array objectAtIndex:indexPath.row];
     cell.model = model;
 return cell;
 }

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WKSingerModel * model = [array objectAtIndex:indexPath.row];
    WKSingerSongListViewController * pushController = [[WKSingerSongListViewController alloc] init];
    pushController.singerModel = model;
    [self.navigationController pushViewController:pushController animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - DZLeftViewDelegate methods
- (void)showHomeView{
    _tableView.userInteractionEnabled = YES;
    [self.leftViewController.view becomeFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.leftViewController.view.frame = leftViewLeftFrame;
        _tableView.alpha = 1;
    }];
}

- (void)showOnlineMusicView{
    _tableView.userInteractionEnabled = YES;
    WKHomeViewController *LocalMusic = [[WKHomeViewController alloc]init];
    [self.leftViewController.view becomeFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.leftViewController.view.frame = leftViewLeftFrame;
        _tableView.alpha = 1;
        [self.navigationController pushViewController:LocalMusic animated:YES];
    }];
}

- (void)showAboutView{
    WKAboutViewController *about = [[WKAboutViewController alloc] init];
    _tableView.userInteractionEnabled = YES;
    [self.leftViewController.view becomeFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.leftViewController.view.frame = leftViewLeftFrame;
        _tableView.alpha = 1;
        [self.navigationController pushViewController:about animated:YES];
    }];
}
-(void)previousToViewController
{
    [self showLeftView];
 
}

- (void)swipeRight:(UISwipeGestureRecognizer *)recognizer{
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [self showLeftView];
    }
}
-(void)showLeftView{
    _tableView.userInteractionEnabled = NO;
    _searchBar.userInteractionEnabled = NO;
    [_searchBar resignFirstResponder];
    [self.leftViewController.view becomeFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.leftViewController.view.frame = leftViewRightFrame;
        _tableView.alpha = 0.6;
    }];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:[touch view]];
    if (!CGRectContainsPoint(leftViewRightFrame, point)) {
        _tableView.userInteractionEnabled = YES;
        _searchBar.userInteractionEnabled = YES;
        [UIView animateWithDuration:0.3 animations:^{
            self.leftViewController.view.frame = leftViewLeftFrame;
            _tableView.alpha = 1;
        }];
    }

}
@end
