//
//  DynamicTableViewController.swift
//  TrendMedia
//
//  Created by Y on 2022/07/18.
//

import UIKit

class DynamicTableViewController: UITableViewController {
    @IBOutlet var dynamicTableView: UITableView!
    
    var section1 = ["공지사항", "실험실", "버전 정보"]
    var section2 = ["개인/보안", "알림", "채팅", "멀티프로필"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dynamicTableView.backgroundColor = .black
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "전체 설정"
        } else if section == 2 {
            return "개인 설정"
        } else if section == 3 {
            return "기타"
        } else {
            return ""
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return section1.count
        } else if section == 2 {
            return section2.count
        } else if section == 3 {
            return 1
        } else {
            return 5
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
        cell.backgroundColor = .black
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = .systemFont(ofSize: 15)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = "설정"
            cell.textLabel?.font = .boldSystemFont(ofSize: 25)
        } else if indexPath.section == 1{
            cell.textLabel?.text = section1[indexPath.row]
        } else if indexPath.section == 2{
            cell.textLabel?.text = section2[indexPath.row]
        } else if indexPath.section == 3{
            cell.textLabel?.text = "고객센터/도움말"
        }
        
        
        return cell
    }

}
