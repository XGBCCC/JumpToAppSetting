//
//  REHelper.m
//  Retriever
//
//  Created by cyan on 2016/10/21.
//  Copyright © 2016年 cyan. All rights reserved.
//

#import "REHelper.h"

@implementation REHelper

+ (id)defaultWorkspace {
    return [@"LSApplicationWorkspace" invokeClassMethod:@"defaultWorkspace"];
}

+ (NSArray *)installedApplications {
    return [[self defaultWorkspace] invoke:@"allInstalledApplications"];
}

+ (NSArray *)installedPlugins {
    return [[self defaultWorkspace] invoke:@"installedPlugins"];
}

+ (NSString *)displayNameForApplication:(id)app {
    return [([app valueForKeyPath:kREDisplayNameKeyPath] ?: [app valueForKey:kRELocalizedShortNameKey]) description];
}

+ (NSString *)bundleIdentifierForApplication:(id)app {
    return [app valueForKey:@"bundleIdentifier"];
}

+ (UIImage *)iconImageForApplication:(id)app {
    return [self iconImageForApplication:app format:0];
}

+ (UIImage *)iconImageForApplication:(id)app format:(NSInteger)format {
    return [UIImage invoke:@"_applicationIconImageForBundleIdentifier:format:scale:"
                 arguments:@[[self bundleIdentifierForApplication:app], @(format), @([UIScreen mainScreen].scale)]];
}

+ (id)applicationForIdentifier:(NSString *)identifier {
    return [@"LSApplicationProxy" invokeClassMethod:@"applicationProxyForIdentifier:" args:identifier, nil];
}

+ (NSArray *)applicationsForIdentifiers:(NSArray *)identifiers {
    NSMutableArray *apps = [NSMutableArray array];
    for (NSString *identifier in identifiers) {
        [apps addObject:[self applicationForIdentifier:identifier]];
    }
    return apps;
}

+ (void)openApplication:(id)app {
    [[self defaultWorkspace] invoke:@"openApplicationWithBundleID:"
                               args:[self bundleIdentifierForApplication:app], nil];
}

+ (void)openApplicationSetting:(id)app{
    NSString *appIdentifier = [self bundleIdentifierForApplication:app];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"Prefs:root=%@",appIdentifier]];
    NSLog(@"%@",url);
    [[self defaultWorkspace] invoke:@"openSensitiveURL:withOptions:" args:url,@{UIApplicationOpenURLOptionUniversalLinksOnly : @NO},nil];
}

@end
