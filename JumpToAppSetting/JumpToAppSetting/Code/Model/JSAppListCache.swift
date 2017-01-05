//
//  JSAppListCache.swift
//  JumpToAppSetting
//
//  Created by JimBo on 2017/1/4.
//  Copyright © 2017年 JimBo. All rights reserved.
//

import Foundation
import CoreSpotlight
import MobileCoreServices

class JSAppListCache{
    static let cache = JSAppListCache()
    
    let appList = REHelper.installedApplications() ?? []
    var filteredAppList:[Any] = []
    
    var appDisplayNameList:[(String,Any)] = []
    var appDisplayNamePinYinList:[(String,Any)] = []
    var appNameDict:[String:(String,String,Any)]=[:]
    private init(){
        var searchableItems:[CSSearchableItem] = []
        //获取所有app名称
        for app in appList{
            if let appDisplayName = REHelper.displayName(forApplication: app){
                let appDisplayNamePinyin = appDisplayName.toPinyin()
                let appIdentifier = REHelper.bundleIdentifier(forApplication: app)
                
                appDisplayNameList.append((appDisplayName,app))
                appDisplayNamePinYinList.append((appDisplayNamePinyin,app))
                
                appNameDict[appIdentifier!] = (appDisplayName,appDisplayNamePinyin,app)
                
                let searchableItemAttributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
                searchableItemAttributeSet.title = appDisplayName
                searchableItemAttributeSet.contentDescription = "点击打开app隐私设置页面"
                var keywords = appDisplayName.components(separatedBy: " ")
                keywords.append(contentsOf: appDisplayNamePinyin.components(separatedBy: " "))
                
                let item = CSSearchableItem(uniqueIdentifier: appIdentifier, domainIdentifier: nil, attributeSet: searchableItemAttributeSet)
                searchableItems.append(item)
            }
            
        }
        CSSearchableIndex.default().indexSearchableItems(searchableItems, completionHandler: nil)
    }
}
