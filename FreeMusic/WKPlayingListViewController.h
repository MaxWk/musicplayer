
#import <UIKit/UIKit.h>
#import "WKBaseViewController.h"

@class WKSongListModel;

@interface WKPlayingListViewController : UIViewController
{
    UITableView * _tableView;
}
@property (nonatomic,strong) NSMutableArray * array;
@end
