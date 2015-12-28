//
//  UIImageView+AutoAdapter.m
//  UIImageView+AutoAdapter
//
//  Created by Jiar on 25/12/15.
//  Copyright © 2015年 Jiar. All rights reserved.
//

#import "UIImageView+AutoAdapter.h"
#import <objc/runtime.h>

@implementation UIImageView (AutoAdapter)

+ (void)load {
    //    [self swizzleSelector:@selector(init) withSelector:@selector(init_AutoAdapter)];
    //    [self swizzleSelector:@selector(awakeFromNib) withSelector:@selector(awakeFromNib_AutoAdapter)];
    //    [self swizzleSelector:@selector(initWithFrame:) withSelector:@selector(initWithFrame_AutoAdapter:)];
    //        [self swizzleSelector:@selector(setFrame:) withSelector:@selector(setFrame_AutoAdapter:)];
    //    [self swizzleSelector:@selector(setNeedsUpdateConstraints) withSelector:@selector(setNeedsUpdateConstraints_AutoAdapter)];
    //    [self swizzleSelector:@selector(needsUpdateConstraints) withSelector:@selector(needsUpdateConstraints_AutoAdapter)];
    //    [self swizzleSelector:@selector(updateConstraints) withSelector:@selector(updateConstraints_AutoAdapter)];
    //    [self swizzleSelector:@selector(updateConstraintsIfNeeded) withSelector:@selector(updateConstraintsIfNeeded_AutoAdapter)];
    //    [self swizzleSelector:@selector(addConstraint:) withSelector:@selector(addConstraint_AutoAdapter:)];
    //    [self swizzleSelector:@selector(addConstraints:) withSelector:@selector(addConstraints_AutoAdapter:)];
    //    [self swizzleSelector:@selector(removeConstraint:) withSelector:@selector(removeConstraint_AutoAdapter:)];
    //    [self swizzleSelector:@selector(removeConstraints:) withSelector:@selector(removeConstraints_AutoAdapter:)];
    //    [self swizzleSelector:@selector(display) withSelector:@selector(display_AutoAdapter)];
    //    [self swizzleSelector:@selector(setNeedsDisplay) withSelector:@selector(setNeedsDisplay_AutoAdapter)];
    //    [self swizzleSelector:@selector(drawRect:) withSelector:@selector(drawRect_AutoAdapter:)];
    //    [self swizzleSelector:@selector(setNeedsLayout) withSelector:@selector(setNeedsLayout_AutoAdapter)];
    //    [self swizzleSelector:@selector(layoutIfNeeded) withSelector:@selector(layoutIfNeeded_AutoAdapter)];
    
    [self swizzleSelector:@selector(setImage:) withSelector:@selector(setImage_AutoAdapter:)];
    [self swizzleSelector:@selector(layoutSubviews) withSelector:@selector(layoutSubviews_AutoAdapter)];
}

+ (void)swizzleSelector:(SEL)originalSelector withSelector:(SEL)swizzledSelector {
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
    if (class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

//- (id)init_AutoAdapter {
//    self = [self init_AutoAdapter];
//    [self autoAdapter];
//    return self;
//}
//
//- (void)awakeFromNib_AutoAdapter {
//    [self awakeFromNib_AutoAdapter];
//    [self autoAdapter];
//}
//
//- (id)initWithFrame_AutoAdapter:(CGRect)frame {
//    self = [self initWithFrame_AutoAdapter:frame];
//    [self autoAdapter];
//    return self;
//}
//- (void)setFrame_AutoAdapter:(CGRect)frame {
//    [self setFrame_AutoAdapter:frame];
//    [self autoAdapter];
//}
//
//- (void)setNeedsUpdateConstraints_AutoAdapter {
//    [self setNeedsUpdateConstraints_AutoAdapter];
//    [self autoAdapter];
//}
//
//- (void)needsUpdateConstraints_AutoAdapter {
//    [self needsUpdateConstraints_AutoAdapter];
//    [self autoAdapter];
//}
//
//- (void)updateConstraints_AutoAdapter {
//    [self updateConstraints_AutoAdapter];
//    [self autoAdapter];
//}
//
//- (void)updateConstraintsIfNeeded_AutoAdapter {
//    [self updateConstraintsIfNeeded_AutoAdapter];
//    [self autoAdapter];
//}
//
//
//- (void)addConstraint_AutoAdapter:(NSLayoutConstraint *)constraint {
//    [self addConstraint_AutoAdapter:constraint];
//    [self autoAdapter];
//}
//
//- (void)addConstraints_AutoAdapter:(NSArray<__kindof NSLayoutConstraint *> *)constraints {
//    [self addConstraints_AutoAdapter:constraints];
//    [self autoAdapter];
//}
//
//- (void)removeConstraint_AutoAdapter:(NSLayoutConstraint *)constraint {
//    [self removeConstraint_AutoAdapter:constraint];
//    [self autoAdapter];
//}
//
//- (void)removeConstraints_AutoAdapter:(NSArray<__kindof NSLayoutConstraint *> *)constraints {
//    [self removeConstraints_AutoAdapter:constraints];
//    [self autoAdapter];
//}
//
//- (void)display_AutoAdapter {
//    [self display_AutoAdapter];
//    [self autoAdapter];
//}
//
//- (void)setNeedsDisplay_AutoAdapter {
//    [self setNeedsDisplay_AutoAdapter];
//    [self autoAdapter];
//}
//
//- (void)drawRect_AutoAdapter:(CGRect)rect {
//    [self drawRect_AutoAdapter:rect];
//    [self autoAdapter];
//}
//
//- (void)setNeedsLayout_AutoAdapter {
//    [self setNeedsLayout_AutoAdapter];
//    [self autoAdapter];
//}
//
//- (void)layoutIfNeeded_AutoAdapter {
//    [self layoutIfNeeded_AutoAdapter];
//    [self autoAdapter];
//}

- (void)setImage_AutoAdapter:(UIImage *)image {
    [self setImage_AutoAdapter:image];
    // setImage:会影响：UISearchBar内部图片样式、UITextField内部图片样式
    if(image != nil && self.superview != nil) {
        [self autoAdapter];
    }
}

- (void)layoutSubviews_AutoAdapter {
    [self layoutSubviews_AutoAdapter];
    if(self.image != nil) {
        [self autoAdapter];
    }
}

static NSMutableDictionary *dic;

+ (NSMutableDictionary *)shareDic {
    if(dic == nil) {
        dic = [[NSMutableDictionary alloc] init];
    }
    return dic;
}

- (void)setCloseAdapter:(BOOL)close {
    NSMutableDictionary *tempDic = [UIImageView shareDic];
    if(close) {
        [tempDic setValue:[NSNumber numberWithBool:close]forKey:[NSString stringWithFormat:@"%p", self]];
    } else {
        [tempDic removeObjectForKey:[NSString stringWithFormat:@"%p", self]];
    }
}

- (void)autoAdapter {
    if([self.superview isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scroll = (UIScrollView *)self.superview;
        NSArray *array = scroll.subviews;
        if(array.count > 2) {
            if(self == array[array.count-1] || self == array[array.count-2]) {
                // 排除干预：UIScrollView进度条
            } else {
                [self toAutoAdapter];
            }
        } else {
            [self toAutoAdapter];
        }
    } else {
        // 排除干预：导航栏内部shadowImage、UISearchBar内部图片样式、UITextField内部图片样式
        if(![self.superview isKindOfClass:[UINavigationBar class]] && ![self.superview.superview isKindOfClass:[UINavigationBar class]] && ![self.superview.superview.superview isKindOfClass:[UISearchBar class]] && ![self.superview isKindOfClass:[UITextField class]]) {
            [self toAutoAdapter];
        }
    }
}

- (void)toAutoAdapter {
    if(![[UIImageView shareDic] objectForKey:[NSString stringWithFormat:@"%p", self]]) {
        if(self.image != nil) {
            CGFloat frameRealityWidth = self.frame.size.width;
            CGFloat imageTheoryWidth = self.frame.size.width/self.image.size.width*self.image.size.height;
            if(frameRealityWidth < imageTheoryWidth) {
                // 高靠齐
                self.contentMode = UIViewContentModeScaleAspectFit;
            } else {
                // 宽靠齐
                self.contentMode = UIViewContentModeScaleAspectFill;
            }
            [self setClipsToBounds:YES];
        }
    }
}

@end
