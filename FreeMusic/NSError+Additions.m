
#import "NSError+Additions.h"

@implementation NSError(Additions)
-(BOOL)isURLError{
    return [self.domain isEqualToString:NSURLErrorDomain];
}
@end
