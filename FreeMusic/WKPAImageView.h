

#import <UIKit/UIKit.h>

@interface WKPAImageView : UIImageView

@property (nonatomic, assign, getter = isCacheEnabled) BOOL cacheEnabled;
@property (nonatomic, strong) UIImageView *containerImageView;

- (id)initWithFrame:(CGRect)frame backgroundProgressColor:(UIColor *)backgroundProgresscolor;
@end
