

#import <UIKit/UIKit.h>

@interface WKLrcView : UIView
{
    UIScrollView * _scrollView;
    NSMutableArray * keyArr;
    NSMutableArray * titleArr;
    NSMutableArray * labels;
}
-(void)setLrcSourcePath:(NSString *)path;
-(void)scrollViewMoveLabelWith:(NSString *)string;
-(void)scrollViewClearSubView;
-(void)selfClearKeyAndTitle;
@end
