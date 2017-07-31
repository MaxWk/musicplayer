

#import <Foundation/Foundation.h>
#define DocumentsPath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]

extern NSString * WKRFRadioViewStatusNotifiation;
extern NSString * WKRFRadioViewSetSongInformationNotification;
@interface Globle : NSObject
@property (nonatomic,assign) BOOL isPlaying;
@property (nonatomic,assign) BOOL isApplicationEnterBackground;
-(void)copySqlitePath;
+(Globle*)shareGloble;
//-(NSMutableArray *)loadSinger;
@end
