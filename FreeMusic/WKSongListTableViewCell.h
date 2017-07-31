
#import "StyledTableViewCell.h"

@class WKSongModel;

@interface WKSongListTableViewCell : StyledTableViewCell
{
    UILabel * nameLabel;
    UILabel * titleLabel;
    UILabel * timeLabel;
}
@property (nonatomic,strong) WKSongModel * model;
@end
