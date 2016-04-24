//
//  Cat.m
//  RuntimeSummary
//
//  Created by 朔 洪 on 16/4/24.
//  Copyright © 2016年 Tuccuay. All rights reserved.
//

#import "Cat.h"

#import "NSObject+Archive.h"

@implementation Cat

- (NSArray *)ignoredNames {
    return @[];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        [self tuc_initWithCoder:aDecoder];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self tuc_encodeWithCoder:aCoder];
}

@end
