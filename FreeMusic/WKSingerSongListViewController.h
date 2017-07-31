

#import <UIKit/UIKit.h>
#import "WKBaseViewController.h"

@class WKSingerModel;

@interface WKSingerSongListViewController : WKBaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
}
@property (nonatomic,strong) WKSingerModel * singerModel;

@end
