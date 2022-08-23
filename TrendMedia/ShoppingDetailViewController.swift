//
//  ShoppingDetailViewController.swift
//  TrendMedia
//
//  Created by Y on 2022/08/24.
//

import UIKit

import SnapKit
import RealmSwift

class ShoppingDetailViewController: UIViewController {
    
    var shopList: UserShoppingList?
    var shopDate: Date?
    var shopTitle: String?
    var shopDetail: String?
    
    
    let dateString: UILabel = {
       let string = UILabel()
        string.text = "등록 날짜"
        return string
    }()
    lazy var dateLabel: UILabel = {
       let label = UILabel()
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.text = "\(shopList!.ShoppingRegisterDate)"
        return label
    }()
    let titleString: UILabel = {
       let string = UILabel()
        string.text = "제목"
        return string
    }()
    lazy var titleLabel: UITextField = {
       let label = UITextField()
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.text = "\(shopList!.ShoppingTitle)"
        return label
    }()
    let detailString: UILabel = {
       let string = UILabel()
        string.text = "내용"
        return string
    }()
    lazy var detailView: UITextView = {
       let label = UITextView()
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.black.cgColor
        label.text = "\(shopList!.ShoppingDetail)"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setConstraints()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
       
    }
    @objc func saveButtonTapped(){
        //상세화면 수정기능 구현 실패...
//        guard let titleText = self.titleLabel.text else {return}
//        guard let contentText = self.detailView.text else {return}
//        let vc = ShoppingTableViewController()
//        try! vc.localRealm.write{
//            vc.localRealm.create(UserShoppingList.self, value: ["objectId": self.shopList!.objectId, "ShoppingDetail": contentText, "ShoppingTitle": titleText], update: .modified)
//            vc.shoppingLists = vc.localRealm.objects(UserShoppingList.self)
//            vc.tableView.reloadData()
//        }
        self.navigationController?.popViewController(animated: true)
    }

    
    func configure(){
        [dateString,dateLabel,titleString,titleLabel,detailString,detailView].forEach {
            view.addSubview($0)
        }
    }
    
    func setConstraints(){
        dateString.snp.makeConstraints { make in
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(22)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.equalTo(view)
        }
        dateLabel.snp.makeConstraints { make in
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(22)
            make.top.equalTo(dateString.snp.bottom)
            make.centerX.equalTo(view)
        }
        titleString.snp.makeConstraints { make in
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(22)
            make.top.equalTo(dateLabel.snp.bottom)
            make.centerX.equalTo(view)
        }
        titleLabel.snp.makeConstraints { make in
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(22)
            make.top.equalTo(titleString.snp.bottom)
            make.centerX.equalTo(view)
        }
        detailString.snp.makeConstraints { make in
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(22)
            make.top.equalTo(titleLabel.snp.bottom)
            make.centerX.equalTo(view)
        }
        detailView.snp.makeConstraints { make in
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(100)
            make.top.equalTo(detailString.snp.bottom)
            make.centerX.equalTo(view)
        }
        
    }
    
    
   

}
