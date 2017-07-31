

#import "WKSingerSongListViewController.h"
#import "WKLoadMoreFooterView.h"
#import "WKMusicViewController.h"
#import "NSDate+Additions.h"
#import "WKSongListTableViewCell.h"
#import "WKSongModel.h"

@interface WKSingerSongListViewController ()<UIScrollViewDelegate>
{
    NSMutableArray * array ;
    BOOL isLoadingMore;
    BOOL isCanLoadMore;
    WKLoadMoreFooterView * footerView;
    int song_total;
}
@end

@implementation WKSingerSongListViewController

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
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigation.leftImage  = [UIImage imageNamed:@"nav_backbtn.png"];
    //    self.navigation.headerImage = [UIImage imageNamed:@"nav_canadaicon.png"];
    self.navigation.rightImage = [UIImage imageNamed:@"nav_music.png"];
    self.navigation.title = [NSString stringWithFormat:@"%@(歌曲%d)",_singerModel.name,_singerModel.songs_total];
    self.navigation.navigaionBackColor =  [UIColor colorWithRed:0.0f/255.0f green:136.0f/255.0f blue:255.0f/255.0f alpha:1.0f];;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.navigation.size.height+self.navigation.origin.y, self.view.size.width, self.view.size.height-self.navigation.size.height)];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundImage"]];
    _tableView.backgroundColor = [UIColor clearColor];

	[self.view addSubview:_tableView];
    
    
    if (_singerModel.songs_total<20) {
        song_total = _singerModel.songs_total;
        isLoadingMore = NO;
    }else{
        song_total = 20;
        isLoadingMore = YES;
    }
    if (isLoadingMore) {
        footerView = [[WKLoadMoreFooterView alloc] initWithFrame:CGRectMake(0, 0, _tableView.size.width, 70)];
        _tableView.tableFooterView = footerView;
    }

//    [ProgressHUD show:nil];
    [self getSongsList];
    // Do any additional setup after loading the view.
}

-(void)rightButtonClickEvent
{
    if (globle.isPlaying) {
        WKMusicViewController * pushController = [WKMusicViewController shareMusicViewController];
        [self.navigationController pushViewController:pushController animated:YES];
    }
}
-(void)getSongsList
{
    MCDataEngine * network = [MCDataEngine new];
    [network getSingerSongListWith:_singerModel.ting_uid :song_total WithCompletionHandler:^(WKSongList *songList) {
        array = songList.songLists;
        [_tableView reloadData];
        [ProgressHUD dismiss];
    } errorHandler:^(NSError *error) {
        
    }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [array count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * dentifier = @"cell";
    WKSongListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:dentifier];
    if (cell == nil) {
        cell = [[WKSongListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:dentifier];
    }
    WKSongModel * model = [array objectAtIndex:indexPath.row];
    
    cell.model = model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WKSongModel * model = [array objectAtIndex:indexPath.row];
    WKMusicViewController * pushController = [WKMusicViewController shareMusicViewController];
    pushController.songListModel = model;
    pushController.array = array;
    pushController.index = indexPath.row;
    [pushController playMusicWithSongLink:model];
    [self.navigationController pushViewController:pushController animated:YES];

}

-(void)loadMore
{
    if (isLoadingMore) {
        [footerView.activeView startAnimating];
        song_total+=20;
        [self performSelector:@selector(loadMoreData) withObject:nil afterDelay:0.1];
        isLoadingMore = NO;
        footerView.titleLabel.text = @"获取中...";
    }
}
-(void)loadMoreData
{
    MCDataEngine * network = [MCDataEngine new];
    [network getSingerSongListWith:_singerModel.ting_uid :song_total WithCompletionHandler:^(WKSongList *songList) {
        
        array = songList.songLists;
        [_tableView reloadData];
        if (song_total> _singerModel.songs_total){
            song_total = _singerModel.songs_total;
            isCanLoadMore = YES; // signal that there won't be any more items to load
        }else{
            isCanLoadMore = NO;
        }
        [self loadMoreCompleted];
    } errorHandler:^(NSError *error) {
        
    }];
}

-(void)loadMoreCompleted
{
    isLoadingMore = YES;
    if (isCanLoadMore) {
        _tableView.tableFooterView = nil;
    }else{
        [footerView.activeView stopAnimating];
    }
}

#define DEFAULT_HEIGHT_OFFSET 44.0f

#pragma mark UIScrollViewDelegate
- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (isLoadingMore && !isCanLoadMore) {
        CGFloat scrollPosition = scrollView.contentSize.height - scrollView.frame.size.height - scrollView.contentOffset.y;
        if (scrollPosition < DEFAULT_HEIGHT_OFFSET) {
            [self loadMore];
        }
    }
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

@end
