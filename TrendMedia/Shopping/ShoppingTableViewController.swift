//
//  ShoppingTableViewController.swift
//  TrendMedia
//
//  Created by Y on 2022/07/19.
//

import UIKit
import RealmSwift

struct Todo{
    var title: String
    var done: Bool
}

class ShoppingTableViewController: UITableViewController {
    
    let repository = UserShoppingListRepository()
    
    var shoppingLists: Results<UserShoppingList>!{
        didSet{
            tableView.reloadData()
            print("tasks changed")
        }
    }
    
    
    var shoppingList = [Todo(title: "칫솔", done: true), Todo(title: "커피", done: false)] {
        //"양말", "밥", "반찬", "옷", "물", "음료수", "소주", "맥주", "김치", "두부", "양주", "와인", "보드카", "위스키", "하이볼", "흑맥주
        didSet{
            tableView.reloadData()
            print(
                "\(oldValue),\(shoppingList)")
        }
    }
    
    lazy var menuItems: [UIAction] = {
        return [
            UIAction(title: "즐겨찾기 순", image: UIImage(systemName: "star.fill"), handler: { _ in
                self.favoriteSortButtonTapped()
            }),
            UIAction(title: "등록일 순", image: UIImage(systemName: "pencil"), handler: { _ in
                self.dateSortButtonTapped()
            }),
            UIAction(title: "완료 순", image: UIImage(systemName: "checkmark.square.fill"), handler: { _ in
                self.doneSortButtonTapped()
            })
        ]
    }()
    lazy var menu: UIMenu = {
           return UIMenu(title: "", options: [], children: menuItems)
       }()

 
    @IBOutlet weak var topView: UIView!
    //클래스는 레퍼런스타입. 인스턴스 자체를 변경하지 않는 이상 한번만 호출 된다.
    //iboutlet viewdidload 호출되기 직전에 nil이 아닌지 nil인지 알 수 있다.
    @IBOutlet weak var addShoppingTextField: UITextField!{
        didSet{
            addShoppingTextField.font = .boldSystemFont(ofSize: 22)
            addShoppingTextField.textColor = .systemRed
            addShoppingTextField.textAlignment = .center
            print("textfield didset")
        }
    }
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var shoppingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        designUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchRealm()
        configure()
    }
    func fetchRealm(){
        //Realm 3. Realm 데이터를 정렬해 tasks 에 담기
        shoppingLists = repository.localRealm.objects(UserShoppingList.self).sorted(byKeyPath: "ShoppingTitle", ascending: true)
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
    
    func configure(){
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonClicked))
//        let sortButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(sortButtonTapped))
//        let filterButton = UIBarButtonItem(title: "필터", style: .plain, target: self, action: #selector(filterButtonTapped))
//        navigationItem.leftBarButtonItems = [sortButton, filterButton]
        if #available(iOS 13.0, *) {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "정렬", menu: menu)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "백업", style: .plain, target: self, action: #selector(backupRestroeButtonTapped))
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(showActionSheet))
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "백업", style: .plain, target: self, action: #selector(backupRestroeButtonTapped))
        }
    }
    @objc func backupRestroeButtonTapped(){
        let vc = BackupRestoreViewController()
        transition(vc, transitionStyle: .present)
    }
    @objc func showActionSheet(_ sender: UIBarButtonItem) {
            let alert = UIAlertController(title: "정렬", message: nil, preferredStyle: .actionSheet)
            let favoriteSort = UIAlertAction(title: "즐겨찾기 순", style: .default, handler: { _ in
                self.favoriteSortButtonTapped()
            })
            let dateSort = UIAlertAction(title: "등록일 순", style: .default, handler: { _ in
                self.dateSortButtonTapped()
            })
            let doneSort = UIAlertAction(title: "완료 순", style: .cancel, handler: { _ in
                self.doneSortButtonTapped()
            })

            [favoriteSort, dateSort, doneSort].forEach { alert.addAction($0) }

            present(alert, animated: true, completion: nil)
        }
    
    @objc func favoriteSortButtonTapped(){
        shoppingLists = repository.localRealm.objects(UserShoppingList.self).sorted(byKeyPath: "ShoppingFavorite", ascending: false)
        tableView.reloadData()
    }
    @objc func dateSortButtonTapped(){
        shoppingLists = repository.localRealm.objects(UserShoppingList.self).sorted(byKeyPath: "ShoppingRegisterDate", ascending: true)
        tableView.reloadData()
    }
    @objc func doneSortButtonTapped(){
        shoppingLists = repository.localRealm.objects(UserShoppingList.self).sorted(byKeyPath: "ShoppingDone", ascending: false)
        tableView.reloadData()
    }
    
    //realm filter query, NSPredicate
    @objc func filterButtonTapped(){
        shoppingLists = repository.localRealm.objects(UserShoppingList.self).filter("diaryTitle CONTAINS[c] '일기'")
            //.filter("diaryTitle = '가오늘의 일기35'")
    }
    
    @IBAction func doneAddShoppingTextField(_ sender: UITextField) {
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
//        shoppingList.append(Todo(title: addShoppingTextField.text!, done: false))
        guard let text = addShoppingTextField.text else {return}
        let task = UserShoppingList(shoppingTitle: text, shoppingDetail: "메모를 작성해 보세요.")
        repository.addRecord(record: task) //Create
        tableView.reloadData()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingLists.count
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
//        cell.cellLabel.text = shoppingList[indexPath.row].title
//        cell.cellLabel.font = .systemFont(ofSize: 12)
//        cell.backgroundColor = .clear
//        cell.starButton.tintColor = .black
//        cell.checkBoxButton.tintColor = .black
//        cell.starButton.setTitle("", for: .normal)
//        cell.checkBoxButton.setTitle("", for: .normal)
//        indexPath.row % 2 == 0 ? cell.starButton.setImage(UIImage(systemName: "star"), for: .normal) : cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
//        let value = shoppingList[indexPath.row].done ? "checkmark.square.fill" : "checkmark.square"
//        cell.checkBoxButton.setImage(UIImage(systemName: value), for: .normal)
        cell.cellLabel.sizeToFit()
        cell.checkBoxButton.tag = indexPath.row
        cell.starButton.tag = indexPath.row
        
        cell.checkBoxButton.addTarget(self, action: #selector(checkBoxButtonTapped(sender: )), for: .touchUpInside)
        shoppingLists[indexPath.row].ShoppingDone == false ? cell.checkBoxButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal) : cell.checkBoxButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        
        cell.starButton.addTarget(self, action: #selector(starButtonTapped(sender: )), for: .touchUpInside)
        shoppingLists[indexPath.row].ShoppingFavorite == false ? cell.starButton.setImage(UIImage(systemName: "star"), for: .normal) : cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        
        cell.cellLabel.text = shoppingLists[indexPath.row].ShoppingTitle
        
     
        
        return cell
    }
    
    // 0번 인덱스의 checkBoxButton만 체크됐다 풀렸다함.. 밑의 starButton 탭기능을 실행해도 0번 checkBoxButton만 동작
    @objc func checkBoxButtonTapped(sender: UIButton){
        print("\(sender.tag)번째 버튼 클릭")

        
//        shoppingList[sender.tag].done = !shoppingList[sender.tag].done
//        print(shoppingList[sender.tag].done)
        try! repository.localRealm.write {
            self.shoppingLists[sender.tag].ShoppingDone = !self.shoppingLists[sender.tag].ShoppingDone
        }
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: sender.tag)], with: .fade)
        self.fetchRealm()
    }
    @objc func starButtonTapped(sender: UIButton){
        print("\(sender.tag)번째 버튼 클릭")

        
//        shoppingList[sender.tag].done = !shoppingList[sender.tag].done
//        print(shoppingList[sender.tag].done)
        
        try! repository.localRealm.write {
            self.shoppingLists[sender.tag].ShoppingFavorite = !self.shoppingLists[sender.tag].ShoppingFavorite
            
        }
        tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
        self.fetchRealm()

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ShoppingDetailViewController()
        vc.shopList = shoppingLists[indexPath.row]
        print(shoppingLists[indexPath.row])
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    } // 편집 가능 셀
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //셀 편집 -> 삭제
        if editingStyle == .delete{
            //Realm Record 삭제
            let taskToDelete = shoppingLists[indexPath.row]
            try! repository.localRealm.write {
                repository.localRealm.delete(taskToDelete)
            }
//            shoppingList.remove(at: indexPath.row)
            tableView.reloadData()
        }
    } //canEditRowAt과 같이써야함
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favorite = UIContextualAction(style: .normal, title: "삭제") { action, view, completionHandler in
            
            self.repository.deleteRecord(record: self.shoppingLists[indexPath.row])
            
            self.fetchRealm()
        }
        return UISwipeActionsConfiguration(actions: [favorite])
    }
    
}
