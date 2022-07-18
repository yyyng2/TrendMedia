//
//  SettingTableViewController.swift
//  TrendMedia
//
//  Created by Y on 2022/07/18.
//

import UIKit

class SettingTableViewController: UITableViewController {

    var birthdayFriends = ["Kim", "Lee", "Park", "Ha", "Ryu"]
        
    override func viewDidLoad() {
        super.viewDidLoad()

        

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "0"
        } else if section == 1 {
            return "1"
        } else if section == 2 {
            return "2"
        } else {
            return "Header"
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        "Footer"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return birthdayFriends.count
        } else if section == 1 {
            return 2
        } else if section == 2 {
            return 5
        } else {
            return 5
        }
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
        
        if indexPath.section == 0 {
            
            cell.textLabel?.text = birthdayFriends[indexPath.row]
            
            cell.textLabel?.textColor = .systemMint
            cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        } else if indexPath.section == 1 {
            cell.textLabel?.text = "cell, section 1 of indexPath"
            cell.textLabel?.textColor = .systemBlue
            cell.textLabel?.font = .boldSystemFont(ofSize: 25)
        } else if indexPath.section == 2 {
            cell.textLabel?.text = "cell, section 2 of indexPath"
            cell.textLabel?.textColor = .systemPink
            cell.textLabel?.font = .boldSystemFont(ofSize: 30)
        }
        
        
        
        return cell
    }

}
