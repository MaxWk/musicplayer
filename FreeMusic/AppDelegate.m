
#import "AppDelegate.h"
#import "MCDataEngine.h"
#import "Globle.h"
#import "WKSingerModel.h"
#import "WKMainViewController.h"
#import "WKHomeViewController.h"
#import <AVFoundation/AVFoundation.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    Globle * globle = [Globle shareGloble];
    [globle copySqlitePath];
    globle.isPlaying = YES;

    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error = nil;
    [session setCategory:AVAudioSessionCategoryPlayback error:&error];
    if (error) {
        NSLog(@"%s %@", __func__, error);
    }
    [session setActive:YES error:nil];
    self.mainViewController = [[WKMainViewController alloc] init];
    self.rootNavigationController = [[UINavigationController alloc] initWithRootViewController:self.mainViewController];
    
    [self.window setRootViewController:self.rootNavigationController];
    
    [self.window makeKeyAndVisible];
    return YES;
}
-(void)addSingerToDB
{
    long long uid = 60467713;//[[array objectAtIndex:index] longLongValue];
    MCDataEngine * engine = [MCDataEngine new];
    [engine getSingerInformationWith:uid WithCompletionHandler:^(NSArray *array) {
//        index+=1;
//        NSLog(@"%ld",(long)index);
//        [self performSelector:@selector(addSingerToDB) withObject:nil afterDelay:0.1];
    } errorHandler:^(NSError *error) {
        
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
	[self becomeFirstResponder];
    [Globle shareGloble].isApplicationEnterBackground = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:WKRFRadioViewSetSongInformationNotification object:nil userInfo:nil];
}
- (void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    NSString * statu = nil;
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
	if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
            case UIEventSubtypeRemoteControlPause:
                statu = @"UIEventSubtypeRemoteControlPause";
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                statu = @"UIEventSubtypeRemoteControlPreviousTrack";
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                statu = @"UIEventSubtypeRemoteControlNextTrack";
                break;
            case UIEventSubtypeRemoteControlPlay:
                statu = @"UIEventSubtypeRemoteControlPlay";
                break;
            default:
                statu = @"UIEventSubtypeNone";
                break;
        }
    }
    NSMutableDictionary * dict = [NSMutableDictionary new];
    [dict setObject:statu forKey:@"keyStatus"];
    [[NSNotificationCenter defaultCenter] postNotificationName:WKRFRadioViewStatusNotifiation object:nil userInfo:dict];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [Globle shareGloble].isApplicationEnterBackground = NO;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
