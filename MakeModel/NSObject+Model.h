//
//  NSObject+Model.h
//  RuntimeSummary
//
//  Created by 朔 洪 on 16/4/23.
//  Copyright © 2016年 Tuccuay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Model)

+ (instancetype)modelWithDict:(NSDictionary *)dict;
+ (instancetype)modelWithDict:(NSDictionary *)dict updateDict:(NSDictionary *)updateDict;

@end
