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
protocol SelectDateDelegate{
    func sendDate(date: String)
}


class ShoppingDetailViewController: UIViewController {

   
    
    var shopList: UserShoppingList?
    
    var repository = UserShoppingListRepository()
    
    let dateformat: DateFormatter = {
          let formatter = DateFormatter()
           formatter.dateFormat = "yyyy.MM.dd. E, a hh:mm"
           return formatter
    }()
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
        string.text = "구매 예정 날짜"
        return string
    }()
    lazy var dateLabel: UILabel = {
        let label = UILabel()
         label.layer.borderWidth = 1
         label.layer.borderColor = UIColor.black.cgColor
//         label.text = "\(shopList!.ShoppingDoDate)"
         return label
    }()
    lazy var dateButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .clear
        return button
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
      
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
        setConstraints()
    }
    @objc func saveButtonTapped(){
        //상세화면 수정기능 구현 실패 -> 성공
        
        guard let titleText = self.titleLabel.text else {return}
        guard let contentText = self.detailView.text else {return}
        guard let dateText = self.dateLabel.text else {return}
        try! repository.localRealm.write{
            repository.localRealm.create(UserShoppingList.self, value: ["objectId": self.shopList!.objectId, "ShoppingDetail": contentText, "ShoppingTitle": titleText, "ShoppingDoDate": dateText], update: .modified)

        }
        
        //이미지 저장 2.
        guard let id = shopList?.objectId else { return }
        do{
            try repository.localRealm.write{
                shopList?.ShoppingTitle = "\(titleText)"
                shopList?.ShoppingDetail = "\(contentText)"
                shopList?.ShoppingDoDate = "\(dateText)"
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
        [shopImageView,searchButton,dateString,dateLabel,dateButton,titleString,titleLabel,detailString,detailView].forEach {
            view.addSubview($0)
        }
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        dateButton.addTarget(self, action: #selector(dateButtonTapped), for: .touchUpInside)
        shopImageView.image = loadImageFromDocument(fileName: "\(shopList!.objectId).jpg")
        dateLabel.text = "\(shopList!.ShoppingDoDate)"
    }
    @objc func searchButtonTapped() {
        let vc = ShoppingSearchImageViewController()
            vc.delegate = self
        transition(vc, transitionStyle: .presentNavigation)
    }
    @objc func dateButtonTapped(){
        let vc = ShoppingCalendarViewController()
        vc.shopList = shopList
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
        dateButton.snp.makeConstraints { make in
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(22)
            make.top.equalTo(dateString.snp.bottom)
            make.centerX.equalTo(view)
        }
        titleString.snp.makeConstraints { make in
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(22)
            make.top.equalTo(dateButton.snp.bottom)
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
extension ShoppingDetailViewController: SelectDateDelegate{
    func sendDate(date: String) {
        print(#function)
        dateLabel.text = date
//        repository.updateDoDate(record: shopList!, date: dateFor)
//        dateButton.setTitle("\(shopList?.ShoppingDoDate)", for: .normal)
    }
    
}

