//
//  ShoppingDetailViewController.swift
//  TrendMedia
//
//  Created by Y on 2022/08/24.
//

import UIKit

import SnapKit
import RealmSwift

protocol SelectImageDelegate{
    func sendImageData(image: UIImage)
}

class ShoppingDetailViewController: UIViewController {

    var shopList: UserShoppingList?

    var shopImageView: UIImageView = {
        let view = UIImageView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
//        view.image = loadImageFromDocument(fileName: \(shopList.objectId).jpg)
        return view
    }()
    var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "photo"), for: .normal)
        return button
    }()
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
        guard let titleText = self.titleLabel.text else {return}
        guard let contentText = self.detailView.text else {return}
        let vc = ShoppingTableViewController()
//        try! vc.localRealm.write{
//            vc.localRealm.create(UserShoppingList.self, value: ["objectId": self.shopList!.objectId, "ShoppingDetail": contentText, "ShoppingTitle": titleText], update: .modified)
//            vc.shoppingLists = vc.localRealm.objects(UserShoppingList.self)
//            vc.tableView.reloadData()
//        }
        
        //이미지 저장 2.
        guard let id = shopList?.objectId else { return }
        do{
            try vc.localRealm.write{
                shopList?.ShoppingTitle = "\(titleText)"
                shopList?.ShoppingDetail = "\(contentText)"
            }
        } catch let error {
            print(error)
        }
        
        if let image = shopImageView.image{
            saveImageToDocument(fileName: "\(id).jpg", image: image)
        }
        
        self.navigationController?.popViewController(animated: true)
    }

    
    func configure(){
        [shopImageView,searchButton,dateString,dateLabel,titleString,titleLabel,detailString,detailView].forEach {
            view.addSubview($0)
        }
        searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        shopImageView.image = loadImageFromDocument(fileName: "\(shopList!.objectId).jpg")
    }
    @objc func searchButtonClicked() {
        let vc = ShoppingSearchImageViewController()
            vc.delegate = self
        transition(vc, transitionStyle: .presentNavigation)
    }
    
    func setConstraints(){
        shopImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view).multipliedBy(0.5)
            make.height.equalTo(shopImageView.snp.width)
            make.centerX.equalTo(view)
        }
        searchButton.snp.makeConstraints { make in
            make.bottom.equalTo(shopImageView.snp.bottom)
            make.right.equalTo(shopImageView.snp.right)
            make.width.height.equalTo(30)
        }
        dateString.snp.makeConstraints { make in
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(22)
            make.top.equalTo(shopImageView.snp.bottom)
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
extension ShoppingDetailViewController: SelectImageDelegate{
    func sendImageData(image: UIImage) {
    
        shopImageView.image = image
        print(#function)
    }
    
}
