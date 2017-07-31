

#import "WKMainTableViewCell.h"
#import "WKPAImageView.h"
#import "UIView+Additions.h"
#import "UIImageView+WebCache.h"
#import "WKSingerModel.h"

@implementation WKMainTableViewCell
-(void)setModel:(WKSingerModel *)model_
{
    _model = model_;
    [headerImageView setImageWithURL:[NSURL URLWithString:_model.avatar_big] placeholderImage:[UIImage imageNamed:@"headerImage"]];
    nameLabel.text = _model.name;
    nameLabel.textColor = [UIColor whiteColor];
    if ([_model.company length]!=0) {
        titleLabel.text = _model.company;
    }else{
         titleLabel.text = @"<无信息>";
    }
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = [UIColor clearColor];
        headerImageView = [[WKPAImageView alloc] initWithFrame:CGRectMake(5, 5, 60, 60)];
        [self.contentView addSubview:headerImageView];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(headerImageView.size.width+headerImageView.origin.x+5, headerImageView.origin.y, self.contentView.size.width-headerImageView.size.width-headerImageView.origin.x-30, 30)];
        nameLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        [self.contentView addSubview:nameLabel];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.origin.x, nameLabel.size.height+nameLabel.origin.y+5, nameLabel.size.width, nameLabel.size.height-10)];
        titleLabel.font = [UIFont systemFontOfSize:13.0f];
        titleLabel.textColor = [UIColor lightGrayColor];

        [self.contentView addSubview:titleLabel];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{

}
@end
