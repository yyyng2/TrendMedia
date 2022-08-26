//
//  ShoppingCalendarView.swift
//  TrendMedia
//
//  Created by Y on 2022/08/26.
//

import UIKit

import SnapKit
import FSCalendar

class ShoppingCalendarView: UIView{
    let calendar: FSCalendar = {
       let calendar = FSCalendar()
        calendar.backgroundColor = .white
        return calendar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI(){
        self.addSubview(calendar)
    }
    
    func setConstraints(){
        calendar.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
