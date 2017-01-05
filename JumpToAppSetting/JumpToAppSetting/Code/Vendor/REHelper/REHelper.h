//
//  REHelper.h
//  Retriever
//
//  Created by cyan on 2016/10/21.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "REDefine.h"
#import "RuntimeInvoker.h"

@interface REHelper : NSObject

+ (NSArray *)installedApplications;

+ (NSArray *)installedPlugins;

+ (NSString *)bundleIdentifierForApplication:(id)app;

+ (NSString *)displayNameForApplication:(id)app;

+ (UIImage *)iconImageForApplication:(id)app;

+ (UIImage *)iconImageForApplication:(id)app format:(NSInteger)format;

+ (id)applicationForIdentifier:(NSString *)identifier;

+ (NSArray *)applicationsForIdentifiers:(NSArray *)identifiers;

+ (void)openApplication:(id)app;

+ (void)openApplicationSetting:(id)app;
@end
