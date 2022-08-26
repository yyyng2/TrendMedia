//
//  ShoppingCalendarViewController.swift
//  TrendMedia
//
//  Created by Y on 2022/08/26.
//

import UIKit

import FSCalendar



class ShoppingCalendarViewController: UIViewController{
    
    var shopList: UserShoppingList?
    
    var delegate: SelectDateDelegate?
    
    var mainView = ShoppingCalendarView()
    
    var repository = UserShoppingListRepository()
    
    var selectDate: Date?
    
    let dateformat: DateFormatter = {
          let formatter = DateFormatter()
           formatter.dateFormat = "yyyy.MM.dd."
           return formatter
    }()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.calendar.delegate = self
        mainView.calendar.dataSource = self
        
        view.backgroundColor = .white
        
        let closeButton = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        navigationItem.leftBarButtonItem = closeButton
        let selectButton = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(selectButtonClicked))
        navigationItem.rightBarButtonItem = selectButton
    }
    
    @objc func closeButtonClicked(){
        dismiss(animated: true)
    }
    
    //날짜 저장
    @objc func selectButtonClicked(){
        
        guard let select = selectDate else {
            showAlert(title: "날짜를 선택해주세요.", buttonTitle: "확인")
            return
        }
        
        let dateString = dateformat.string(from: select)
        
        repository.updateDoDate(record: shopList!, date: dateString)
        
        
        self.delegate?.sendDate(date: dateString)
        self.dismiss(animated: true)
        

    }
    
}
extension ShoppingCalendarViewController: FSCalendarDelegate, FSCalendarDataSource{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
        selectDate = date
        
    }
}
