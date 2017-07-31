

#import "KHNetworkEngine.h"
@class WKSongListModel,WKSongList,WKSongModel;

@interface MCDataEngine : KHNetworkEngine
typedef void (^SalesResponseBlock) (NSArray *array);
typedef void (^WKSongListModelResponseBlock) (WKSongList *songList);
typedef void (^WKSongModelResponseBlock) (WKSongModel *songModel);
typedef void (^WKSongLrcResponseBlock)(BOOL sucess,NSString * path);
typedef void (^WKSongLinkDownLoadResponseBlock)(BOOL sucess,NSString * path);

-(MKNetworkOperation *)getSingerInformationWith:(long long)tinguid
                                                WithCompletionHandler:(SalesResponseBlock)completion
                                             errorHandler:(MKNKErrorBlock)errorHandler;

-(MKNetworkOperation *)getSingerSongListWith:(long long)tinguid :(int) number
                WithCompletionHandler:(WKSongListModelResponseBlock)completion
                         errorHandler:(MKNKErrorBlock)errorHandler;

-(MKNetworkOperation *)getSongInformationWith:(long long)songID
                        WithCompletionHandler:(WKSongModelResponseBlock)completion
                                 errorHandler:(MKNKErrorBlock)errorHandler;

-(MKNetworkOperation *)getSongLrcWith:(long long)tingUid :(long long)songID :(NSString *)lrclink
                WithCompletionHandler:(WKSongLrcResponseBlock)completion
                         errorHandler:(MKNKErrorBlock)errorHandler;

-(MKNetworkOperation *)downLoadSongWith:(long long)tingUid :(long long)songID :(NSString *)songLink
                WithCompletionHandler:(WKSongLinkDownLoadResponseBlock)completion
                         errorHandler:(MKNKErrorBlock)errorHandler;


@end
