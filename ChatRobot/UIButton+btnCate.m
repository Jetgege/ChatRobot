//
//  UIButton+btnCate.m
//  ChatRobot
//
//  Created by Jet on 16/6/22.
//  Copyright © 2016年 Jet. All rights reserved.
//

#import "UIButton+btnCate.h"
#import <objc/runtime.h>
static const void *urlTagKey = &urlTagKey;
@implementation UIButton (btnCate)

- (NSString *)urlTag {
    return objc_getAssociatedObject(self, urlTagKey);
}

- (void)setUrlTag:(NSString *)urlTag {
    objc_setAssociatedObject(self, urlTagKey, urlTag, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
