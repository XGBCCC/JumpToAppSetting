//
//  JSAppListController.swift
//  JumpToAppSetting
//
//  Created by JimBo on 2017/1/3.
//  Copyright © 2017年 JimBo. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift



class JSAppListController: UITableViewController {

    let disposeBag = DisposeBag()
    
    let appList = JSAppListCache.cache.appList
    var filteredAppList:[Any] = []
    
    var appDisplayNameList:[(String,Any)] = JSAppListCache.cache.appDisplayNameList
    var appDisplayNamePinYinList:[(String,Any)] = JSAppListCache.cache.appDisplayNamePinYinList
    var appNameDict:[String:(String,String,Any)]=JSAppListCache.cache.appNameDict
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        tableView.register(UINib.init(nibName: "JSAppListCell", bundle: nil), forCellReuseIdentifier: JSAppListCell.Identifier)
        //初始化数据
        
        
        //Search
        searchController.searchBar.rx.text.orEmpty.throttle(0.3, scheduler: MainScheduler.instance).distinctUntilChanged().subscribe(onNext: { [weak self] (query) in
            self?.filterAppList(query)
        }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
        searchController.searchBar.rx.cancelButtonClicked.observeOn(MainScheduler.instance).subscribe({[weak self]_ in
            self?.searchController.searchBar.text = ""
            self?.tableView.reloadData()
        }).addDisposableTo(disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredAppList.count
        }
        return appList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JSAppListCell.Identifier, for: indexPath) as! JSAppListCell
        if searchController.isActive && searchController.searchBar.text != "" {
            cell.setupWithApp(filteredAppList[indexPath.row])
        }else {
            cell.setupWithApp(appList[indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if searchController.isActive && searchController.searchBar.text != "" {
            REHelper.openApplicationSetting(filteredAppList[indexPath.row])
        }else{
            REHelper.openApplicationSetting(appList[indexPath.row])
        }
    }

    func filterAppList(_ query:String){
        filteredAppList.removeAll()
        for appIdentifier in appNameDict.keys {
            if let appName = appNameDict[appIdentifier] {
                if appName.0.lowercased().contains(query.lowercased()) || appName.1.lowercased().contains(query.lowercased()) {
                    filteredAppList.append(appName.2)
                }
            }
        }
        tableView.reloadData()
    }
}
