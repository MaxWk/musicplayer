

#import "WKMusicViewController.h"
#import "WKRadioView.h"
#import "FSPlaylistItem.h"
#import "MCDataEngine.h"
#import "WKSongModel.h"
#import <MediaPlayer/MediaPlayer.h>
#import "WKPlayingListViewController.h"
#import "NSObject+LKDBHelper.h"



@interface WKMusicViewController ()<RFRadioViewDelegate>
@property (nonatomic,weak)RFRadioView * radioView;
@end

@implementation WKMusicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
+(WKMusicViewController *)shareMusicViewController
{
    static WKMusicViewController * musicViewController;
    if (musicViewController == nil) {
        musicViewController = [[WKMusicViewController alloc] init];
    }
    return musicViewController;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigation.leftImage  = [UIImage imageNamed:@"nav_backbtn.png"];
    self.navigation.headerImage = [UIImage imageNamed:@"nav_canadaicon.png"];

    self.navigation.navigaionBackColor =  [UIColor colorWithRed:0.0f/255.0f green:136.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    RFRadioView * radioView = [[RFRadioView alloc] initWithFrame:CGRectMake(0,self.navigation.size.height+self.navigation.origin.y, 320,self.view.size.height-self.navigation.size.height-self.navigation.origin.y)];
    radioView.delegate = self;
    self.radioView = radioView;
    
    [self.view addSubview:radioView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackgroundSetSongInformation:) name:WKRFRadioViewSetSongInformationNotification  object:nil];

}

- (WKSongModel *)songModel
{
    if (!_songModel) {
        _songModel = [[WKSongModel alloc]init];
        _songModel.songLink = _songListModel.songLink;
        _songModel.lrclink = _songListModel.lrclink;
        _songModel.file_duration = _songListModel.file_duration;
        _songModel.title = _songListModel.title;
    }
    return _songModel;
}

-(BOOL)isLocalMP3
{
    NSFileManager * manager = [[NSFileManager alloc] init];
    NSString *filePath = [DocumentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%lld/%lld/%lld.mp3",_songListModel.ting_uid,_songListModel.song_id,_songListModel.song_id]];
    if ([manager fileExistsAtPath:filePath]) {
        return YES;
    }
    return NO;
}
-(NSString *)localMP3path
{
    NSString *filePath = [DocumentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%lld/%lld/%lld.mp3",_songListModel.ting_uid,_songListModel.song_id,_songListModel.song_id]];
    return filePath;
}
-(void)playMusicWithSongLink:(WKSongModel*)model
{
    FSPlaylistItem * item = [[FSPlaylistItem alloc] init];
    _songListModel =model;
    if ([self isLocalMP3]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            item.title = model.title;
            item.url = model.songLink;
            _radioView.songlistModel = model;
            _radioView.songModel = model;
            globle.isPlaying = YES;
            self.navigation.title =model.title;
            _radioView.selectedPlaylistItem = item;
            [self.radioView setRadioViewLrc];
            if (globle.isApplicationEnterBackground) {
                [self applicationDidEnterBackgroundSetSongInformation:nil];
            }

        });
    }else{
        MCDataEngine * network = [MCDataEngine new];
        [network getSongInformationWith:model.song_id WithCompletionHandler:^(WKSongModel *songModel) {
            item.title = songModel.title;
            item.url = songModel.songLink;
            _radioView.songlistModel = model;
            _radioView.songModel = songModel;
            [_radioView setRadioViewLrc];
            globle.isPlaying = YES;
            _songModel = songModel;
            self.navigation.title =songModel.title;
            _radioView.selectedPlaylistItem = item;
            if (globle.isApplicationEnterBackground) {
                [self applicationDidEnterBackgroundSetSongInformation:nil];
            }
        } errorHandler:^(NSError *error) {
            [ProgressHUD showError:@"网络错误"];
        }];
    }
}
-(void)applicationDidEnterBackgroundSetSongInformation:(NSNotification *)notification
{
    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
		NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
		[dict setObject:_songListModel.title forKey:MPMediaItemPropertyTitle];
		[dict setObject:_songListModel.author  forKey:MPMediaItemPropertyArtist];
//		[dict setObject:[[MPMediaItemArtwork alloc] initWithImage:[UIImage imageNamed:@"headerImage.png"]] forKey:MPMediaItemPropertyArtwork];
		[[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:nil];
		[[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
	}
}

-(void)playModleIsLock
{
    FSPlaylistItem * item = [[FSPlaylistItem alloc] init];
    item.title = self.songModel.title;
    item.url = self.songModel.songLink;
    [_radioView setSelectedPlaylistItem:item];
    _radioView.songlistModel = _songListModel;
    _radioView.songModel = self.songModel;
    globle.isPlaying = YES;
    self.navigation.title =self.songModel.title;
}
#pragma
#pragma mark RFRadioViewDelegate
-(void)radioView:(RFRadioView *)view musicStop:(NSInteger)playModel
{
    WKSongModel * model = nil;
    switch (playModel) {
        case 0:
        {
            self.index+=1;
            if (self.index>=[self.array count]) {
                self.index = 0;
            }
            model = [self.array objectAtIndex:self.index];
            [self playMusicWithSongLink:model];
        }
            break;
        case 1:
        {
            NSInteger  number = [self.array count];
            model = [self.array objectAtIndex:arc4random()%number];
            [self playMusicWithSongLink:model];
        }
            break;
        case -1:
        {
            model = self.songListModel;
            [self playModleIsLock];
        }
            break;
        default:
            break;
    }
}
-(void)radioView:(RFRadioView *)view preSwitchMusic:(UIButton *)pre
{
    if ([self.array count]!=0) {
        self.index-=1;
        if (self.index<0) {
            self.index = 0;
        }
        WKSongModel * model = [self.array objectAtIndex:self.index];
        [self playMusicWithSongLink:model];
    }
}
-(void)radioView:(RFRadioView *)view nextSwitchMusic:(UIButton *)next
{
    if ([self.array count]!=0) {
        self.index+=1;
        if (self.index==[self.array count]) {
            self.index = self.index-1;
        }
        WKSongModel * model = [self.array objectAtIndex:self.index];
        [self playMusicWithSongLink:model];
    }
}
-(void)radioView:(RFRadioView *)view playListButton:(UIButton *)btn
{
    WKPlayingListViewController * viewController = [[WKPlayingListViewController alloc] init];
    UINavigationController * navigation = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self.navigationController presentViewController:navigation animated:YES completion:^{
        
    }];
}

#pragma mark - 数据库存入借口
-(void)radioView:(RFRadioView *)view downLoadButton:(UIButton *)btn
{
    MCDataEngine * network = [MCDataEngine new];
    [network downLoadSongWith:_songListModel.ting_uid :_songListModel.song_id :view.selectedPlaylistItem.url WithCompletionHandler:^(BOOL sucess, NSString *path) {
//ting_uid;song_id;songName;lrcLink;songLink;songPicBig;albumid;
        WKSongModel *downloadSong = [WKSongModel new];
        downloadSong.ting_uid = _songListModel.ting_uid;
        downloadSong.song_id = _songListModel.song_id;
        downloadSong.title = _songListModel.title;
        downloadSong.songLink = path;
        NSString *temp =  [path stringByDeletingLastPathComponent];
        NSString *lrclink = [temp stringByAppendingString:@".lrc"];
        downloadSong.lrclink = lrclink;
        downloadSong.pic_big = _songListModel.pic_big;
        downloadSong.album_id = _songListModel.album_id;
        downloadSong.author = _songListModel.author;
        downloadSong.file_duration = _songListModel.file_duration;
        downloadSong.album_title = _songListModel.album_title;
        downloadSong.isLocal = 1;
        [WKSongModel insertWhenNotExists:downloadSong];//根据模型的属性存入数据库  注意：模型属性与数据库字段名要一致
        _radioView.downLoadButton.enabled = NO;
    } errorHandler:^(NSError *error) {
        _radioView.downLoadButton.enabled = YES;
    }];
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
