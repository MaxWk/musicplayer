

#import <UIKit/UIKit.h>
#import "WKBaseViewController.h"
#import "WKLeftViewController.h"

@interface WKMainViewController : WKBaseViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView * _tableView;
    CGRect leftViewLeftFrame;//左视图在左边时位置
    CGRect leftViewRightFrame;//左视图在右边时位置
    

}
@property (strong,nonatomic) UISearchBar *searchBar;

@end
