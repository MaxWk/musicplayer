
#import <UIKit/UIKit.h>
@class WKMainViewController,WKHomeViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSInteger index;
    NSMutableArray * array;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) WKMainViewController *mainViewController;
@property (strong, nonatomic) UINavigationController * rootNavigationController;
@property (strong, nonatomic) WKHomeViewController * homeViewController;
@property (strong, nonatomic) UINavigationController * homeNavigationController;


@property (strong, nonatomic) UINavigationController * tudouNavigationController;


@property (strong, nonatomic) UITabBarController * tabBarController;

@end
