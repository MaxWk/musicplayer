

#import <UIKit/UIKit.h>

@class WKSongModel;

@interface WKMySongCell : UITableViewCell
{
    UILabel * nameLabel;
    UILabel * titleLabel;
    UILabel * timeLabel;
}
@property (nonatomic,strong) WKSongModel * model;
@end
