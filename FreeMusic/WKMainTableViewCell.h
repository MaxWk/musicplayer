
#import <UIKit/UIKit.h>
#import "StyledTableViewCell.h"
@class WKPAImageView;
@class WKSingerModel;

@interface WKMainTableViewCell : StyledTableViewCell
{
    
    WKPAImageView * headerImageView;
    UILabel * nameLabel;
    UILabel * titleLabel;
    
}
@property (nonatomic,strong) WKSingerModel * model;
@end
