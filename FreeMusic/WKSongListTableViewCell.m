

#import "WKSongListTableViewCell.h"
#import "UIView+Additions.h"
#import "WKSongModel.h"

@implementation WKSongListTableViewCell
-(NSString*)TimeformatFromSeconds:(int)seconds
{
    int totalm = seconds/(60);
    int h = totalm/(60);
    int m = totalm%(60);
    int s = seconds%(60);
    if (h==0) {
        return  [[NSString stringWithFormat:@"%02d:%02d", m, s] substringToIndex:5];
    }
    return [NSString stringWithFormat:@"%02d:%02d:%02d", h, m, s];
}

-(void)setModel:(WKSongModel *)model
{
    _model = model;
    nameLabel.text = _model.title;
    nameLabel.textColor = [UIColor whiteColor];
    timeLabel.text =[self TimeformatFromSeconds:_model.file_duration];
    titleLabel.text = [NSString stringWithFormat:@"%@•%@",_model.author,_model.album_title];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType =UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundColor = [UIColor clearColor];
        // Initialization code
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(8, 5, self.contentView.size.width-16-60, 25)];
        nameLabel.font = [UIFont systemFontOfSize:16.0f];
//        nameLabel.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:nameLabel];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.size.width+nameLabel.origin.x, nameLabel.size.height/2+nameLabel.origin.y, 40, 25)];
        timeLabel.font = [UIFont systemFontOfSize:14.0f];
//        timeLabel.backgroundColor = [UIColor blueColor];
        timeLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:timeLabel];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameLabel.origin.x, nameLabel.size.height+nameLabel.origin.y, nameLabel.size.width, 25)];
        titleLabel.font = [UIFont systemFontOfSize:14.0f];
//        titleLabel.backgroundColor = [UIColor greenColor];
        titleLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:titleLabel];
    }
    return self;
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}

@end
