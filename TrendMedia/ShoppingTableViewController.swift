//
//  ShoppingTableViewController.swift
//  TrendMedia
//
//  Created by Y on 2022/07/19.
//

import UIKit

class ShoppingTableViewController: UITableViewController {
    
    var shoppingList: [String] = ["칫솔", "커피"]

 
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var addShoppingTextField: UITextField!
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var shoppingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        designUI()        
    }
    
    func designUI(){
        shoppingLabel.text = "쇼핑"
        shoppingLabel.textAlignment = .center
        shoppingLabel.font = .boldSystemFont(ofSize: 20)
        AddButton.setTitle("추가", for: .normal)
        AddButton.setTitleColor(.black, for: .normal)
        AddButton.backgroundColor = .systemGray5
        AddButton.layer.cornerRadius = 8
        addShoppingTextField.layer.cornerRadius = 8
        addShoppingTextField.placeholder = "무엇을 구매하실 건가요?"
        topView.layer.cornerRadius = 8
    }
    
    @IBAction func doneAddShoppingTextField(_ sender: UITextField) {
    }
    @IBAction func addButtonTapped(_ sender: UIButton) {
        shoppingList.append(addShoppingTextField.text!)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    } // 높이로 헤더 공백 생성
    
//      여백으로 헤더 공백
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return " "
//        } else {
//            return .none
//        }
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingTableViewCell", for: indexPath) as! ShoppingTableViewCell
        cell.cellLabel.text = shoppingList[indexPath.row]
        cell.cellLabel.font = .systemFont(ofSize: 12)
        cell.backgroundColor = .clear
        cell.starButton.tintColor = .black
        cell.checkBoxButton.tintColor = .black
        cell.starButton.setTitle("", for: .normal)
        cell.checkBoxButton.setTitle("", for: .normal)
        indexPath.row % 2 == 0 ? cell.starButton.setImage(UIImage(systemName: "star"), for: .normal) : cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        indexPath.row % 2 == 0 ? cell.checkBoxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal) : cell.checkBoxButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    } // 편집 가능 셀
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            shoppingList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    } //canEditRowAt과 같이써야함
    
}
