

#import <UIKit/UIKit.h>
#import "WKBaseViewController.h"

@class WKSongModel;

@interface WKMusicViewController : WKBaseViewController



@property (nonatomic,strong) WKSongModel * songModel;
@property (nonatomic,strong) WKSongModel * songListModel;
@property (nonatomic,strong) NSMutableArray * array;
@property (nonatomic,assign) NSInteger index;

+(WKMusicViewController *)shareMusicViewController;
-(void)playMusicWithSongLink:(WKSongModel*)model;

@end
