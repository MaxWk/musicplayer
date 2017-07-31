#import "WKHomeViewController.h"
#import "WKMySongCell.h"
#import "WKMusicViewController.h"
#import "WKSongModel.h"
#import "WKLeftViewController.h"
#import "WKAboutViewController.h"
#import "WKMainViewController.h"

@interface WKHomeViewController()<UITableViewDataSource,UITableViewDelegate,WKLeftViewDelegate>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic, strong) WKLeftViewController *leftViewController;

@end

@implementation WKHomeViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigation.leftImage  =[UIImage imageNamed:@"Home_Icon_Highlight"];
    self.navigation.rightImage = [UIImage imageNamed:@"nav_music.png"];
    //    self.navigation.headerImage = [UIImage imageNamed:@"nav_canadaicon.png"];
    self.navigation.title = @"本地音乐";
    self.navigation.navigaionBackColor = [UIColor colorWithRed:0.0f/255.0f green:136.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    
    UITableView *tableView = [[UITableView alloc]init];
    tableView.frame = CGRectMake(0,self.navigation.height, SCREEN_WIDTH, SCREEN_HEIGHT-self.navigation.height);
    tableView.dataSource = self;
    tableView.delegate = self;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage"]];
    tableView.backgroundColor = [UIColor clearColor];

    self.tableView = tableView;
    [self.view addSubview:tableView];
    
    leftViewLeftFrame = CGRectMake(-kMainWidth, 0, kViewWidth, kViewHeight);
    leftViewRightFrame = CGRectMake(self.view.x,CGRectGetMaxY(self.navigation.frame)-44, self.view.width/2, self.view.height);
    self.leftViewController = [[WKLeftViewController alloc] init];
    self.leftViewController.delegate = self;
    self.leftViewController.view.frame = leftViewLeftFrame;
    [self.view addSubview:self.leftViewController.view];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    [self.view addGestureRecognizer:swipe];
    
  
    [self refresh];
    [self loadLocalSong];
}

-(void)rightButtonClickEvent
{
    if (globle.isPlaying) {
        WKMusicViewController * pushController = [WKMusicViewController shareMusicViewController];
        [self.navigationController pushViewController:pushController animated:YES];
    }
}

- (void)loadLocalSong
{
    WKSongModel * model = [WKSongModel new];
    _dataSource = [model mySong];
    [_tableView reloadData];

    if (_dataSource.count) {
        NSIndexPath * indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
}

- (void)refresh
{
    __unsafe_unretained UITableView *tableView = self.tableView;
    
    tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self updateData];
        });
    }];
    tableView.mj_header.automaticallyChangeAlpha = YES;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [tableView reloadData];
            [tableView.mj_footer endRefreshing];
        });
    }];
    
    footer.hidden = YES;
    tableView.mj_footer = footer;
    
}
- (void)updateData
{
    [_dataSource removeAllObjects];
    [self loadLocalSong];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * dentifier = @"mysongcell";
    WKMySongCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
    if (cell == nil) {
        cell = [[WKMySongCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dentifier];
    }
    WKSongModel * model = [_dataSource objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WKSongModel * model = [_dataSource objectAtIndex:indexPath.row];
    WKMusicViewController * pushController = [WKMusicViewController shareMusicViewController];
    pushController.songListModel = model;
    pushController.array = _dataSource;
    pushController.index = indexPath.row;
    [pushController playMusicWithSongLink:model];
    [self.navigationController pushViewController:pushController animated:YES];
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
#pragma mark - 数据库删除接口
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        WKSongModel *model = _dataSource[indexPath.row];//取出数据源里面的模型
        NSFileManager*fileManager=[[NSFileManager alloc]init];
        [fileManager removeItemAtPath:model.lrclink error:nil];//删除文件
        [fileManager removeItemAtPath:model.songLink error:nil];
        [WKSongModel deleteToDB:model];//通过模型直接删除数据库里面的表格数据
        [_dataSource removeObjectAtIndex:indexPath.row];//删除数据源里面的模型
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
   
}
#pragma mark - DZLeftViewDelegate methods
- (void)showHomeView{
    _tableView.userInteractionEnabled = YES;
    WKMainViewController *Online = [[WKMainViewController alloc]init];
    [self.leftViewController.view becomeFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.leftViewController.view.frame = leftViewLeftFrame;
        _tableView.alpha = 1;
        [self.navigationController pushViewController:Online animated:YES];
    }];
}

- (void)showOnlineMusicView{
    _tableView.userInteractionEnabled = YES;
    [self.leftViewController.view becomeFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.leftViewController.view.frame = leftViewLeftFrame;
        _tableView.alpha = 1;
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
-(void)showLeftView{
    _tableView.userInteractionEnabled = NO;
    [self.leftViewController.view becomeFirstResponder];
    self.leftViewController.view.alpha = 1;
    [UIView animateWithDuration:0.3 animations:^{
        self.leftViewController.view.frame = leftViewRightFrame;
        _tableView.alpha = 0.6;
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
        _tableView.userInteractionEnabled = YES;
        [UIView animateWithDuration:0.3 animations:^{
            self.leftViewController.view.frame = leftViewLeftFrame;
            _tableView.alpha = 1;
        }];
    }
    
}

@end
