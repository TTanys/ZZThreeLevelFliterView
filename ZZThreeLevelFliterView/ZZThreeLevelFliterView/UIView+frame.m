//
//  UIView+frame.m
//
//

#import "UIView+frame.h"

@implementation UIView (frame)

- (void)setWidth:(CGFloat)width {
    CGSize size =CGSizeMake(width, self.frame.size.height);
    self.frame =CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}
- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGSize size =CGSizeMake(self.frame.size.width, height);
    self.frame =CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}
- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setLeft:(CGFloat)left {
    [self setX:left];
}
- (CGFloat)left {
    return self.x;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setTop:(CGFloat)top {
    [self setY:top];
}
- (CGFloat)top {
    return self.y;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY {
    return self.center.y;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size {
    return self.frame.size;
}

- (void)makeCorner:(float)r {
    if (r < 0) {
        r = 0;
    }
    self.layer.cornerRadius = r;
    self.layer.masksToBounds = YES;
}

@end
