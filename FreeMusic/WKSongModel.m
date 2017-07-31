
#import "WKSongModel.h"

@implementation WKSongModel

+(NSString *)getTableName
{
    return @"FMSongListTable";
}

+(int)getTableVersion
{
    return 1;
}
+(NSString *)getPrimaryKey
{
    return @"song_id";
}
-(NSMutableArray *)mySong
{
    NSMutableArray * array = [WKSongModel searchWithWhere:nil orderBy:nil offset:0 count:0];
    
    NSMutableArray * temp = [NSMutableArray new];
    NSMutableArray * temp1 = [NSMutableArray new];
    for (WKSongModel * sub in array) {
        if ([sub.title length]!=0) {
            if ([sub.songLink length]!=0) {
                [temp addObject:sub];
            }else{
                [temp1 addObject:sub];
            }
        }
    }
    [temp addObjectsFromArray:temp1];
    return temp;
}

-(NSString *)description
{
    return _title;
}

@end

@implementation WKSongList

-(id)init
{
    if (self = [super init]) {
        self.songLists = [NSMutableArray new];
    }
    return self;
}


@end
