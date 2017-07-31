
#import <UIKit/UIKit.h>
#import "ZZNavigationView.h"
#import "UIView+Additions.h"
#import "WKSingerModel.h"
#import "UIImageView+WebCache.h"
#import "MCDataEngine.h"
#import "Globle.h"
#import "ProgressHUD.h"


@interface WKBaseViewController : UIViewController<ZZNavigationViewDelegate>
{
    Globle * globle;
}
@property (nonatomic,strong) ZZNavigationView * navigation;
@end
