//
//  LeftViewController.swift
//  LYSideMenu
//
//  Created by linyi on 16/6/2.
//  Copyright © 2016年 linyi. All rights reserved.
//

import UIKit

class LeftViewController: UIViewController {

    let titlesDictionary = ["开通会员", "QQ钱包", "网上营业厅", "个性装扮", "我的收藏", "我的相册", "我的文件"]
    
    @IBOutlet weak var settingTableView: UITableView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingTableView.tableFooterView = UIView()
        
        self.view.frame = CGRectMake(0, 0, Common.screenWidth * 0.8, Common.screenHeight)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension LeftViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titlesDictionary.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        cell!.textLabel?.text = titlesDictionary[indexPath.row]
        
        return cell!
    }
}